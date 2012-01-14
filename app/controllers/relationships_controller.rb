class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    node = Node.find(params[:node_id])
    node.push_follower(current_user.id)

    respond_to do |format|
      format.html { redirect_to node_path }
      format.js
    end
  end

  def destory
    node = Node.find(params[:node_id])
    node.pull_follower(current_user.id)

    respond_to do |format|
      format.html { redirect_to node_path }
      format.js
    end

  end


end
