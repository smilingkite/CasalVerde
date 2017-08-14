class Api::PagesController < ApplicationController
  def index
    render status: 200, json: {
      pages: Page.all
    }.to_json
  end
end
