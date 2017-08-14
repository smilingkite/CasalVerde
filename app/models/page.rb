class Page < ApplicationRecord
  has_many :paragraphs, dependent: :destroy
  has_many :carousels

  validates :name, presence: true
end
