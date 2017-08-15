class Api::PhotosController < ApplicationController
  def index
    render status: 200, json: {
      photos: Photo.all
    }.to_json
  end
end
