class PriceSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :min_days, :nightly_price, :extra_price, :saturdays_only, :service_costs
end
