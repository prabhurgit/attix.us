class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate :page => params[:page], :per_page =>30
  end

  def index
    @total_users_count = User.count
    @hot_users = User.hot.paginate :page => params[:page], :per_page => 30
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
