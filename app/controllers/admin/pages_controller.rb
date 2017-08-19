class Admin::PagesController < Admin::BaseController

  def index
    @pages = Page.order(:id)
    @homepage = Page.find_by(name: "home_page")
    @photos = Photo.all
    render json: @pages
  end

  def create
    @page = Page.new(page_params)
    @page.hidden = true

    if @page.save
      # redirect_to admin_pages_path
      render status: 201, json: {
        message: "page created",
        page: page
      }.to_json
    else
      # render :index
      render status: 422, json: {
        errors: page.errors
      }.to_json
    end
  end

  def update
    page = Page.find(params[:id])

    if page.update(page_params)
      # redirect_to admin_pages_path
      render status: 201, json: {
        message: "page updated",
        page: page
      }.to_json
    else
      render status: 422, json: {
        errors: page.errors
      }.to_json
    end
  end

  def destroy
    page = Page.find(params[:id])
    page.destroy
    render status: 200, json: {
      message: "page deleted"
    }.to_json

    # if page.destroy
    #   redirect_to admin_pages_path
    # else
    #   redirect_to admin_pages_path
    # end
  end

  def edit
    @page = Page.find(params[:id])
  end

  private

  def page_params
    params.require(:page).permit(:name, :hidden)
  end
end
