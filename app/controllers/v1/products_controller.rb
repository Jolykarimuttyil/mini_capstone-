class V1::ProductsController < ApplicationController
  
  before_action :authoricate_admin, except: [:index, :show]

  def index
   products = Product.all

    search_terms = params[:q]
    if search_terms
      products = products.where("name iLIKE?", "%#{search_terms}%")
    end 
    render json: products.as_json
  end

  def create
    if current_user && current_user.admin
    product = Product.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description],
      supplier_id: 1       
    )
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages  }, status:  :unprocessable_entity
    end
    else render json: {}, status: :unauthorized

  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product.as_json
  end

  def update
    product = Product.find_by(id: params[:id])
    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    product.image_url = params[:image_url] || product.image_url
    product.description = params[:description] || product.description
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {message: "Product successfully destroyed!"}
  end
 
end 
end 