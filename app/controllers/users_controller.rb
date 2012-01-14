# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate :page => params[:page], :per_page =>30
  end

  def index
    if params[:search]
      result = Redis::Search.query("User", params[:search])
      ids = result.collect { |r| r["id"] }
      @hot_users = User.find(ids).paginate(:page => params[:page], :per_page => 50)
    else
      @hot_users = User.hot.paginate :page => params[:page], :per_page => 30
    end
    @total_users_count = User.count

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
