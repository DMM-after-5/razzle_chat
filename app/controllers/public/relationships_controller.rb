class Public::RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to root_path
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
