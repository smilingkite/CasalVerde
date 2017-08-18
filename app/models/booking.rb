class Booking < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  scope :current_booking, -> { where('check_in <= ? AND check_out >= ?', Date.today, Date.today).limit(1) }
  scope :upcoming_bookings, -> { where('check_in > ?', Date.today) }
  scope :past_bookings, -> { where('check_out < ?', Date.today) }
  scope :reserved_bookings, -> { upcoming_bookings.where(confirmed: false) }
  scope :confirmed_bookings, -> { upcoming_bookings.where(confirmed: true) }
  scope :last_checked_out, -> { past_bookings.order(:check_out).limit(1) }

  before_save :set_total_price
  before_save :set_booleans

  validate :check_in_must_be_after_today, :check_out_must_be_after_check_in,
           :check_in_must_be_saturday, :check_out_must_be_saturday,
           :has_minimum_days, :has_available_price
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 10 }
  validates :phone, presence: true, length: { maximum: 255 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :people, presence: true

  def self.available?(check_in, check_out)
    Booking.all.each do |booking|
      if (booking.starts_at < check_out) && (booking.ends_at > check_in)
        return false
      end
    end
    # Check if a price is set for all days, if not it is not available.
    (check_in..check_out).each do |date|
      return false unless Price.where('start_date <= ? AND end_date >= ?', date, date).exists?
    end
    true
  end

  def full_name
    "#{title} #{first_name} #{last_name}"
  end

  def full_address_html
    ''"<br />
    #{street_name} #{street_number} <br />
    #{zip_code} <br />
    #{city} <br />
    #{phone} <br />
    #{email}
    "''
  end

  def number_of_days
    (check_out - check_in).to_i - 1
  end

  private

  def set_booleans
    self.confirmed ||= false
    self.paid ||= false
  end

  def set_total_price
    self.total_price ||= Price.total_price(check_in, check_out, people)
  end

  def check_in_must_be_after_today
    if !check_in.present? || (check_in - Date.today).to_i < 1
      errors.add(:check_in, 'must be in the future')
    end
  end

  def check_out_must_be_after_check_in
    if !check_out.present? || (check_out - check_in).to_i < 1
      errors.add(:check_out, 'must be after check in')
    end
  end

  def check_in_must_be_saturday
    if Price.saturdays_only?(check_in) && !check_in.saturday?
      errors.add(:check_in, 'must be a Saturday')
    end
  end

  def check_out_must_be_saturday
    if Price.saturdays_only?(check_out) && !check_out.saturday?
      errors.add(:check_out, 'must be a Saturday')
    end
  end

  def has_minimum_days
    if Price.min_days_at_check_in(check_in) > (check_out - check_in).to_i
      errors.add(:check_out, 'not enough days selected')
    end
  end

  def has_available_price
    unless Price.where('start_date <= ? AND end_date >= ?', check_out, check_in).exists?
      errors.add(:check_in, 'booking not available at this date')
    end
  end
end
