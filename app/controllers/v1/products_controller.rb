class V1::ProductsController < ApplicationController
  def index
    product = Product.all
    render json: product.as_json 
  end
  
  def show 
    product = Product.find_by(id: params["id"])
    render json: product.as_json
  end

  def create 
    product = Product.new(
      name: params["input_name"],
      price: params["input_price"],
      description: params["input_description"]
      )
  
    product.save
    render json: product.as_json 
  end  
end
