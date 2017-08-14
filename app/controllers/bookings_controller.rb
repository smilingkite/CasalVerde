# frozen_string_literal: true
class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def show
    @booking = Booking.find(params[:id])
  end

  # def create
  #   booking = Booking.new(booking_params)
  #
  #   if booking.save
  #     render status: 200, json: {
  #       booking: booking
  #     }.to_json
  #   else
  #     render status: 422, json: {
  #       errors: booking.errors
  #     }.to_json
  #   end
  # end

  # def taken
  #   excluded_dates = []
  #   Booking.upcoming_bookings.each do |booking|
  #     date_from = booking.check_in
  #     date_to = booking.check_out
  #     date_array = (date_from...date_to).map(&:to_s)
  #
  #     date_array.each do |date|
  #       excluded_dates << date
  #     end
  #   end
  #   render status: 201, json: {
  #     message: 'Booked Dates',
  #     dates: excluded_dates
  #   }.to_json
  # end

  # private
  #
  # def booking_params
  #   params.require(:booking).permit(:check_in, :check_out, :first_name,
  #                                   :last_name, :title, :phone, :email, :street_name, :street_number,
  #                                   :city, :zip_code, :people)
  # end
end
