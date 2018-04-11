class FollowshipsController < ApplicationController
 
  # params代表著我們傳入的參數，你可以使用rails routes看看路由裡面的參數，
  # 在你現在的路由 create裡面 params[:id] => 這個在這邊代表的是當前的使用者，而params[:following_id]代表的才是他要follow的人
  # 而在destroy裡面params[:id]就代表了他follow的人
 
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = 'Successfully followed'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end

end
