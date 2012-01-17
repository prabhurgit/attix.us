# coding: utf-8
class NodesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:search]
      result = Redis::Search.query("Node", params[:search])
      ids = result.collect { |r| r["id"] }
      @nodes = Node.find(ids).paginate(:page => params[:page], :per_page => 50)
    else
      @nodes = Node.all.paginate(:page => params[:page], :per_page => 50)
    end
    @node = Node.new

  end

  def show
    @node = Node.find(params[:id])
    #@posts = @node.posts.last_actived
    @posts = @node.posts.last_actived.includes(:node, :user, :last_comment_user).paginate :page => params[:page], :per_page => 30
    @users = User.where(:id.in => @node.follower_ids).limit(20)
  end

  def create
    @node = Node.new(params[:node])

    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_path, notice: 'Node was successfully created.' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { redirect_to nodes_path, notice: 'Node already exist'  }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :ok }
    end
  end

end
