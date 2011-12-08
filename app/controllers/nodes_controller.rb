class NodesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @nodes = Node.all
    @node = Node.new
  end

  def show
    @node = Node.find(params[:id])
    #@posts = @node.posts.last_actived
    @posts = @node.posts.paginate :page => params[:page], :per_page => 30
  end

  def create
    @node = Node.new(params[:node])

    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_path, notice: 'Post was successfully created.' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
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
