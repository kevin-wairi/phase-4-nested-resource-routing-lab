class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
     items = user.items
     else
      items = Item.all     
    end
    render json: items, include: :user
  end
  def show
    item = if params[:user_id]
             User.find(params[:user_id]).items.find_by(id: params[:id])
           else
             Item.find(params[:id])
           end
  
    if item.nil?
      render json: { error: "item not found" }, status: :not_found
    else
      render json: item, include: :user
    end
  end
  

  def create
    user = User.find(params[:user_id])
    item = user.items.create(name: "Garden gnomes",description: "No refunds", price: 23)
    render json: item,status: :created
  end
  private

  def render_record_not_found_response
    render json: {error: "user is not found"},status: :not_found
  end
  end
