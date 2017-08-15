class Api::ParagraphsController < ApplicationController
skip_before_filter :verify_authenticity_token
before_filter :set_page

  def create
    paragraph = @page.paragraphs.new(paragraph_params)
    # @paragraph.page_id = @page.id

    if paragraph.save
      render status: 200, json: {
        message: "paragraph created",
        page: @page,
        paragraph: paragraph
      }.to_json
    else
      render status: 422, json: {
        message: "paragraph coudn't be created",
        errors: paragraph.errors
      }.to_json
    end
  end

  def update
    paragraph = @page.paragraphs.find(params[:id])
    if paragraph.update(paragraph_params)
      render status: 200, json: {
        message: "paragraph  updated",
        page: @page,
        paragraph: paragraph
      }.to_json
    else
      render status: 422, json: {
        message: "paragraph could not be updated",
        errors: paragraph.errors
      }.to_json
    end
  end

  def destroy
    paragraph = @page.paragraphs.find(params[:id])
    paragraph.destroy

    render status: 200, json: {
      message: "paragraph  deleted",
      page: @page,
      paragraph: paragraph
    }.to_json
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def paragraph_params
    params.require(:paragraph).permit(:heading, :text)
  end
end
