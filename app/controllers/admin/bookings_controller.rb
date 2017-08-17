class Admin::BookingsController < Admin::BaseController
  def index
    @bookings_current = Booking.current_booking
    @bookings_last = Booking.last_checked_out
    @bookings_reserved = Booking.reserved_bookings
    @bookings_confirmed = Booking.confirmed_bookings
    @bookings = Booking.all
    render json: @bookings
  end

  def past
    @bookings = Booking.past_bookings
  end

  def update
    booking = Booking.find(params[:id])

    if booking.update(booking_params) && params[:booking][:confirmed] != nil
      confirmed_text = booking.confirmed? ? "Un-confirm" : "Confirm"

      render status: 200, json: {
        id: booking.id,
        confirmed_text: confirmed_text,
        confirmed_status: booking.confirmed
      }.to_json

    elsif booking.update(booking_params) && params[:booking][:paid] != nil
      paid_text = booking.paid? ? "Not paid" : "Paid"

      render status: 200, json: {
        id: booking.id,
        paid_text: paid_text,
        paid_status: booking.paid
      }.to_json

    else
      render status: 422, json: {
        errors: booking.errors
      }.to_json
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    # head :no_content

    render status: 200, json: {
      message: "Review deleted"
    }.to_json
    # redirect_to admin_bookings_path
  end

  private
    def booking_params
      params.require(:booking).permit(:confirmed, :paid)
    end
end
