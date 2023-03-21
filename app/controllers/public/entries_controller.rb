class Public::EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to root_path
    else
      #userのshowで必要な変数をすべて此処に記述
      render root_path
    end
  end

  def create_all
    params[:user_ids].each do |user_id|
      @entry = Entry.new(entry_params)
      @entry.user_id = user_id
      if @entry.save

      else
        #userのshowで必要な変数をすべて此処に記述
        render root_path
      end
    end
    redirect_to root_path
  end

  def update
    entry = Entry.find(params[:id])
    if entry.update(entry_status: true)
      redirect_to root_path
    else
      #userのshowで必要な変数をすべて此処に記述
      render root_path
    end
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy!
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :room_id)
  end
end
