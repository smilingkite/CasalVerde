class Admin::CarouselsController < Admin::BaseController
  def index
    @page = Page.find(params[:page_id])
    render json: @page
  end
end
