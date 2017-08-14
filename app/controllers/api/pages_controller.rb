class Api::PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
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

  def create
    page = Page.new(page_params)
    page.hidden = true

    if page.save
      render status: 201, json: {
        message: "Page created",
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
      message: "Page deleted"
    }.to_json
  end

  def update
    page = Page.find(params[:id])
    if page.update(page_params)
      render status: 200, json: {
        message: "Page updated",
        page: page
      }.to_json
    else
      render status: 422, json: {
        message: "The page could not be updated",
        errors: page.errors
      }.to_json
    end
  end

  private

  def page_params
    params.require(:page).permit(:name, :hidden)
  end
end
