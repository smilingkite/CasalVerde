class Admin::PagesController < Admin::BaseController
  def index
    @pages = Page.all
    @homepage = Page.find_by(name: "home_page")
    @photos = Photo.all
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to admin_pages_path
    else
      render "index"
    end
  end


  def edit
    @page = Page.find(params[:id])
  end

  private

  def page_params
    params.require(:page).permit(:name)
  end
end
