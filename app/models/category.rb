class Category < ApplicationRecord
  has_many :Category_products
  has_many :products, through: :category_products

end
