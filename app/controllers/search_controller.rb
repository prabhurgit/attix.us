class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    search_text = params[:keywords]
    @keywords = params[:keywords]
    @search = Sunspot.search(Post) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
    end
  end
end
