class PricesController < ApplicationController

  def calculate_price
    price = Price.total_price(params["price"]["checkin"].to_date, params["price"]["checkout"].to_date, (params["price"]["guests"]).to_i)

    if price
      render status: 200, json: {
        price: price
      }.to_json
    else
      render status: 422, json: {
        errors: price.errors
      }.to_json
    end
  end

end
