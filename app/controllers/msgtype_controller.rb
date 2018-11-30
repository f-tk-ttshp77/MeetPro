class MsgtypeController < ApplicationController
  before_action :general_user

  def new
    @msgtypes = Msgtype.all
  end

  def create
    Msgtype.create(content: params[:name])
    redirect_to('/msgtype/new')
  end
end
