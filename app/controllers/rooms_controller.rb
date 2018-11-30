class RoomsController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_room_user, only: [:show]

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @gomessages = @messages.where(msgtype: 11)
    @agmessages = @messages.where(msgtype: 12)
    @pbmessages = @messages.where(msgtype: 13)
    @demessages = @messages.where(msgtype: 14)
  end

  def create
    @roommk = Room.new(name: params[:name], roomidname: params[:roomidname], password: params[:room_password])
    if @roommk.save
      RoomUser.create(room_id: @roommk.id, user_id: current_user.id)
      flash[:notice] = "会議室を作成しました"
      redirect_to("/users/my_page")
    else
      flash[:notice] = "作成に失敗しました。有効な値を入力してください"
      @user = User.find(current_user.id)
      @rooms = current_user.rooms
      render("users/registrations/my_page")
    end
  end

  def addition
    @room = Room.find_by(roomidname: params[:roomidname])
    if @room && @room.authenticate(params[:room_password])
      @room_user = RoomUser.find_by(room_id: @room.id, user_id: current_user.id)
      if @room_user
        redirect_to("/users/my_page")
        flash[:notice] = "既に追加されている会議室です"
      else
        RoomUser.create(room_id: @room.id, user_id: current_user.id)
        flash[:notice] = "会議室を追加しました"
        redirect_to("/users/my_page")
      end
    else
      flash[:notice] = "存在しない会議室です"
      redirect_to("/users/my_page")
    end
  end

  def state_change
    @room = Room.find(params[:id])
    if @room.room_state == "0"
      @room.room_state = 1
      @room.save
      redirect_to("/users/my_page")
    else
      @room.room_state = 0
      @room.save
      redirect_to("/users/my_page")
    end
  end

  def authenticate_room_user
    @room_user = Room.find(params[:id]).room_users.find_by(user_id: current_user.id)
    if !@room_user
      flash[:notice] = "入室権限がありません。"
      redirect_to("/users/my_page")
    end
  end

end
