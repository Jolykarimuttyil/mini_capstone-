class V1::CartedProductController < ApplicationController
  before_action :authenticate_user 
  def index  
    cartedproduct = CartedProduct.where(user_id: current_user.id, status: "carted")
    render json: cartedproduct.as_json
  end 
  
  def create 
    cartedproduct = CartedProduct.new(
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted", 
      user_id: current_user.id

      )
    if cartedproduct.save
      render json: cartedproduct.as_json
    else
      render json: {errors: cartedproduct.errors.full_messages  }, status:  :unprocessable_entity
    end
  end  
end
