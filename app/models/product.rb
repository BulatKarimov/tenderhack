class Product < ApplicationRecord
  has_one_attached :image

  scope :search, lambda { |q|
    where('name ILIKE :q OR manufacturer ILIKE :q', q: "%#{q}%")
  }
end
