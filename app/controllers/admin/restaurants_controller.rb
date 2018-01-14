class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
def index
  end
@restaurants = Restaurant.all #這個 Action 的目的是要顯示全部餐廳的資料。
end
