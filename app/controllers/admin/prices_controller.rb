class Admin::PricesController < Admin::BaseController
  skip_before_filter :authenticate_user!

  # GET /admin/prices
  def index
    @prices = Price.all.order(:start_date)
    @price = Price.new
    render json: @prices
  end

  # GET /admin/prices/:id
  def edit
    @price = Price.find(params[:id])
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      redirect_to admin_prices_path
    else
      redirect_to admin_prices_path
    end
  end

  # PATCH/PUT /admin/prices/:id
  def update
    @price = Price.find(params[:id])
    if @price.update(price_params)
      redirect_to admin_prices_path
    else
      render :edit
    end
  end

  # DELETE /admin/prices/:id
  def destroy
    @price = Price.find(params[:id])
    @price.destroy
    redirect_to admin_prices_path
  end

  private
    def price_params
      params.require(:price).permit(:start_date, :end_date, :min_days,
                     :nightly_price, :extra_price, :service_costs,
                     :saturdays_only)
    end
end
