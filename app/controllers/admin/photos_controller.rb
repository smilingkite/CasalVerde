class Admin::PhotosController < Admin::BaseController

  def index
    @photos = Photo.all.order(:id)
    @page = Page.find_by(name: 'home_page')
    @photo = Photo.new
    render json: @photos
  end

  def create
    @photo = Photo.new(photo_params)
    @page = Page.find_by(name: 'home_page')
    @photo.photo_page_id = @page.id
    @photo.photo_page_type = 'Carousel'

    if @photo.save
      # redirect_to controller: :photos, action: :index
      render status: 201, json: {
        message: 'photo uploaded',
        photo: photo
      }.to_json
    else
      # render "index"
      render status: 422, json: {
        errors: photo.errors
      }.to_json
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])

    if photo.update(photo_params)
      # redirect_to controller: :photos, action: :index
      render status: 201, json: {
        message: 'photo updated',
        photo: photo
      }.to_json
    else
      # render "edit"
      render status: 422, json: {
        errors: paragraph.errors
      }.to_json
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    render status: 200, json: {
      message: 'photo deleted'
    }.to_json
    # if @photo.destroy
    #   redirect_to admin_photos_path
    # else
    #   redirect_to admin_photos_path, notice: "Fuck you"
    # end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
