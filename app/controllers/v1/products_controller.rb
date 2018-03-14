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

    if product.save 
      render json: product.as_json
    else 
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end 
  end  

  def update 
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    product.name = params["input_name"] || product.name 
    product.price = params["input_price"] || product.price 
    product.description = params["input_description"] || product.description
    if product.save 
      render json: product.as_json
    else 
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end 
  end 
  def destory 
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    product.destory     
    render json: {message: "product succesfully destory"}
  end
end
