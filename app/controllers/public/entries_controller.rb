class Public::EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_room, only: [:create_all]

  # 一人に招待を送る
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to root_path
    else
      #userのshowで必要な変数をすべて此処に記述
      render root_path
    end
  end

  # 複数人に対して招待を送る
  def create_all
    @room = Room.find(params[:entry][:room_id])
    # number＝ルームに招待済みの人数＋招待しようとしている人数
    # params[:user_ids]はパラメータで送られてきた複数のuser_idです
    if params[:user_ids].present?
      number = @room.users.length + params[:user_ids].length

      # ルームの上限人数を超えないかチェック
      if number > @room.members_status.to_i
        if @room.owner_id == current_user.id
          @room.update(members_status: number)
        else
          redirect_to root_path(room_id: @room.id), alert: "招待に失敗しました(人数をオーバーしています)"
          return
        end
      end


      user_names = []
      params[:user_ids].each do |user_id|
        user_names << User.find(user_id).nickname
        @entry = Entry.new(entry_params)
        @entry.user_id = user_id
        if @entry.save

        else
          #userのshowで必要な変数をすべて此処に記述
          render root_path(room_id: @room.id), alert: '招待の送信に失敗しました'
        end

      end
      redirect_to root_path(room_id: @room.id), notice: "#{user_names.join(',')}へ招待を送りました"
    else
      redirect_to root_path(room_id: @room.id), alert: '招待先が未選択です'
    end
  end

  def update
    entry = Entry.find(params[:id])
    if entry.update(entry_status: true)
      redirect_to root_path(room_id: entry.room_id)
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

  # 参加済みのルームか確認するためのメソッド
  def ensure_room
    if params[:entry][:room_id].present?
      @room = Room.find(params[:entry][:room_id])
      unless @room.entried?(current_user)
        redirect_to root_path, alert: 'ルームに参加済みでない方は招待を送れません'
      end
    end
  end
end
