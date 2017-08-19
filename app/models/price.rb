class Price < ApplicationRecord
  scope :except_past, -> { where('end_date >= ?', Date.today).order(:end_date) }

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_cant_be_before_start_date
  validate :not_overlapping

  def end_date_cant_be_before_start_date
    if start_date >= end_date
      errors.add(:start_date, 'Has to be at an earlier date than end date')
    end
  end

  def not_overlapping
    Price.all.each do |price|
      if (price.start_date <= end_date) && (price.end_date >= start_date) && (id != price.id)
        errors.add(:start_date, 'Overlaps a current time period')
      end
    end
  end

  def self.total_price(checkin, checkout, people = 8)
    extra_people = if saturdays_only?(checkin)
                     people - 8
                   else
                     people - 4
               end

    weeks = (checkout - checkin).to_i / 7
    total_price = 500 + weeks * Price.price_at_week(checkin, extra_people)
    total_price
  end

  def self.price_at_week(date, extra_people)
    price = Price.where('start_date <= ? AND end_date >= ?', date, date).last
    total = price.weekly_price
    total += price.extra_price * extra_people if extra_people > 0
    total
  end

  def self.saturdays_only?(check_in)
    price = Price.where('start_date <= ? AND end_date >= ?', check_in, check_in).last
    price.saturdays_only == true
  end

  def self.min_days_at_check_in(check_in)
    price = Price.where('start_date <= ? AND end_date >= ?', check_in, check_in).first
    price.min_days
  end
end
