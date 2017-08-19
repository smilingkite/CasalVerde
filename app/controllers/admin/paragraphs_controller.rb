class Admin::ParagraphsController < Admin::BaseController
  def index
    @paragraphs = Paragraph.all.order(id: :asc)
    @page = Page.find(params[:page_id])
    @paragraph = Paragraph.new
    render json: @paragraphs
  end

  def create
    @paragraph = Paragraph.new(paragraph_params)
    @page = Page.find(params[:page_id])
    @paragraph.page_id = @page.id

    if @paragraph.save
      # redirect_to admin_page_paragraphs_path
      render status: 201, json: {
        message: 'paragraph created',
        paragraph: paragraph
      }.to_json
    else
      # render "index"
      render status: 422, json: {
        errors: paragraph.errors
      }.to_json
    end
  end

  def update
    paragraph = Paragraph.find(params[:id])

    if paragraph.update(paragraph_params)
      # redirect_to admin_page_paragraphs_path
      render status: 201, json: {
        message: 'paragraph updated',
        paragraph: paragraph
      }.to_json
    else
      # render :edit
      render status: 422, json: {
        errors: paragraph.errors
      }.to_json
    end
  end

  def destroy
    @paragraph = Paragraph.find(params[:id])
    @page = Page.find(params[:page_id])
    @paragraph.destroy

    render status: 200, json: {
      message: 'paragraph deleted'
    }.to_json

    # if @paragraph.destroy
    #   redirect_to admin_page_paragraphs_path
    # else
    #   redirect_to admin_page_paragraphs_path
    # end
  end

  private

  def paragraph_params
    params.require(:paragraph).permit(:heading, :text)
  end
end
