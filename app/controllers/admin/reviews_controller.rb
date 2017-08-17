class Admin::ReviewsController < Admin::BaseController
skip_before_filter :authenticate_user!
  # GET /admin/prices
  def index
    @reviews = Review.all.order(:created_at)
    @review = Review.new
    render json: @reviews
  end

  # DELETE /admin/prices/:id
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    render status: 200, json: {
      message: "Review deleted"
    }.to_json
  end
end
