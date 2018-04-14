class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  # 評論過的餐廳:@commented_restaurants
  # 收藏過的餐廳	@favorited_restaurants	
  # 自己去追蹤的人	@followings	
  # 追蹤自己的人	@followers
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers # 需至 User Model 自訂方法
  end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
