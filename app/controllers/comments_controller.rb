class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if(params[:post_id])
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(params[:comment])
      @comment.user = current_user
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, :notice => "Comment Created!" }
        format.json { render post: @post, comment: @comment }
        format.js
      else
        format.html { redirect_to @post, :notice => "Create fall!" }
        format.json { render status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    #@comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :ok }
    end
  end


end
