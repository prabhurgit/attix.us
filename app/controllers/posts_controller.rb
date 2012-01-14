# coding: utf-8
class PostsController < ApplicationController

  before_filter :authenticate_user!

  def following
    @posts = Post.following(current_user.id).paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.last_actived.includes(:node, :user, :last_comment_user).paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.asc(:_id).all.paginate :page => params[:page], :per_page =>30

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    if !params[:node_id].blank?
      @post.node_id = params[:node_id]
      @node = Node.find(params[:node_id])
      if @node.blank?
        render 404
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @node = @post.node
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.content = @post.raw_content
    @post.user_id = current_user.id
    @post.node_id = params[:node_id] || params[:post][:node_id]
    #if @post.save
    #  Resque.enqueue(MarkdownHighlighter, @post.id)
    #end


    respond_to do |format|
      if @post.save
        format.html { redirect_to node_path(@post.node_id), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def create_comment
    @post = Post.find(params[:id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      @msg = "Comment created!"
    else
      @msg = @comment.errors.full_messages.join("<br />")
    end
  end

end
