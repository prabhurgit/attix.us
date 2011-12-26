class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    @hot_users = User.hot.paginate :page => 1, :per_page => 30
    @new_registration_users = User.all.paginate :page => params[:page], :per_page => 30
  end
end
