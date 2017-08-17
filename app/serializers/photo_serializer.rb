class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :image, :photo_page_type, :photo_page_id
end
