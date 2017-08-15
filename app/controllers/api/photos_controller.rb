class Api::PhotosController < ApplicationController
  def index
    render status: 200, json: {
      photos: Photo.all
    }.to_json
  end

  def show
    photo = Photo.find(params[:id])

    render status: 200, json: {
      photo: photo
    }.to_json
  end

  def create
    photo = Photo.new(photo_params)

    if photo.save
      render status: 201, json: {
        message: 'Photo added',
        photo: photo
      }.to_json
    else
      render status: 422, json: {
        errors: photo.errors
      }.to_json
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :photo_page_type, :photo_page_id)
  end
end
