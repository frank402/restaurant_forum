class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
def index
  end
@restaurants = Restaurant.all #這個 Action 的目的是要顯示全部餐廳的資料。
end

 def new
   @restaurant = Restaurant.new # add new"新增" 這個動作
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
     params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description)
   end
 end