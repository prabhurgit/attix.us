# coding: utf-8
class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @keywords = Segment.split(params[:keywords])
    search_text = @keywords.join(" ")
    @search = Sunspot.search(Post) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
      order_by :last_comment_at, :desc
    end
  end
end
