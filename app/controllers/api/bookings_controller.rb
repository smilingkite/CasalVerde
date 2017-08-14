class Api::BookingsController < ApplicationController
  def index
    render status: 200, json: {
      bookings: Booking.all
    }.to_json
  end
end
