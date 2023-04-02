class Public::RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
      redirect_to root_path(params: {room_id: @room.id})
    else
      redirect_to root_path
    end
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  private

  def relationship_params
    params.require(:relationship).permit(:follower_id, :followed_id)
  end

end
