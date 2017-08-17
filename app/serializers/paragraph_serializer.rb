class ParagraphSerializer < ActiveModel::Serializer
  attributes :id, :text, :page_id, :heading
end
