class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
def index
@restaurants = Restaurant.all #這個 Action 的目的是要顯示全部餐廳的資料。
end

 def new
   @restaurant = Restaurant.new # add new"新增" 這個動作
 end

 def show
     #@restaurant = Restaurant.find(params[:id])
 end

 def edit

 end

 def destroy
     @restaurant.destroy
     redirect_to admin_restaurants_path
     flash[:alert] = "restaurant was deleted"
   end

 def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end
#
 def create
     @restaurant = Restaurant.new(restaurant_params)
     if @restaurant.save
       flash[:notice] = "restaurant was successfully created"
       redirect_to admin_restaurants_path
     else
       flash.now[:alert] = "restaurant was failed to create"
       render :new
     end
   end

   private

   def restaurant_params
     params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image)
   end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

 end