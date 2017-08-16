# frozen_string_literal: true
class PagesController < ApplicationController
  def photogallery; end

  def index
    @page = Page.find_by(name: 'home_page')
    @carousel = @page.carousels.find_by(name: 'home')
    @paragraphs = @page.paragraphs.all
    @reviews = Review.last_3_reviews
  end

  def show
    @page = Page.find(params[:id])
    # @name = @page.name
    @paragraphs = @page.paragraphs.all
  end

  def prices
    @prices = Price.except_past
  end
end
