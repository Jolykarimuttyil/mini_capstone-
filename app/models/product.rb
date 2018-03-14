class Product < ApplicationRecord
  validates name, presence: true, uniqueness: true 
  validates price, presence: true
  validates price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 }

   
end
