class BookingSerializer < ActiveModel::Serializer
  attributes :id, :check_in, :check_out, :first_name, :last_name, :title, :phone, :email, :street_name, :street_number, :city, :zip_code, :people, :total_price, :confirmed, :paid
end
