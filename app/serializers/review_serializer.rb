class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :stars, :review
end
