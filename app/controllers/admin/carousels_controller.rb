class Admin::CarouselsController < Admin::BaseController

  # does NOT work right now. Needs route if we want it to work through the api
  # and as it was before. 

  def index
    @page = Page.find(params[:page_id])
    render json: @page
  end
end
