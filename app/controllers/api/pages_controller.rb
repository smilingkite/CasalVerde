class Api::PagesController < ApplicationController
  def index
    render status: 200, json: {
      pages: Page.all
    }.to_json
  end

  def show
    page = Page.find(params[:id])

    render status: 200, json: {
      page: page
    }.to_json
  end
end
