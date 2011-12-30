class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  include MarkdownWithSyntax
  include Sunspot::Mongoid

  key :title

  # Field:
  field :title
  field :content
  field :raw_content
  field :comments_count, :type => Integer, :default => 0
  field :last_comment_at, :type => DateTime
  field :last_comment_id, :type => Integer
  field :follower_ids, :type => Array, :default => []

  # Reference:
  referenced_in :node
  has_many :comments, :dependent => :destroy
  belongs_to :user, :inverse_of => :posts
  belongs_to :last_comment_user, :class_name => 'User'

  # Validation:
  validates_presence_of :title, :node_id, :user_id, :title, :raw_content

  # Counter_cache
  counter_cache :name => :user, :inverse_of => :posts
  counter_cache :name => :node, :inverse_of => :posts


  # indexes
  index :node_id
  index :last_comment_at
  index :user_id

  # Sunspot Full-Text Search
  searchable do
    text :title, :stored => true
    text :content, :stored => true
    text :comments, :stored => true do
      comments.map{ |comment| comment.content }
    end
    time :last_comment_at
  end


  # Scopes
  scope :last_actived, desc('last_comment_at').desc('created_at')

  def last_comment_user_email
    user = User.find(:last_comment_user_id)
    user.email
  end


  def node_title
    self.node.title
  end

  before_save :update_content
  def update_content
    self.content = markdown_with_syntax(self.raw_content)
  end

  before_save :set_last_comment_at
  def set_last_comment_at
    self.last_comment_at = Time.now
  end
end
