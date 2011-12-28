class Node
  include Mongoid::Document

  key :title

  # Fields:
  field :title
  field :posts_count, :type => Integer, :default => 0

  # References
  references_many :posts

  # Scope
  default_scope :order => 'create at'
  scope :hot, desc(:comments_count, :posts_count)



  # Validation
  validates_presence_of :title
  validates_uniqueness_of :title
end
