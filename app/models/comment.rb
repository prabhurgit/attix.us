class Comment
  include Mongoid::Document
  include Mongoid::CounterCache
  include MarkdownWithSyntax

  # Field
  field :content
  field :raw_content

  # Validation
  validates :raw_content, :presence => true, :length => { :minimum => 1}

  # Reference
  belongs_to :post, :inverse_of => :comments
  belongs_to :user, :inverse_of => :comments

  # Counter Cache
  counter_cache :name => :post, :inverse_of => :comments
  counter_cache :name => :user, :inverse_of => :comments

  after_create :update_parent_post
  def update_parent_post
    self.post.last_comment_at = Time.now
    self.post.last_comment_id = self.id
    self.post.last_comment_user_id = self.user_id
    #self.post.push_follower(self.user_id)
    self.post.save
  end

  before_save :update_content
  def update_content
    self.content = markdown_with_syntax(self.raw_content)
  end


end
