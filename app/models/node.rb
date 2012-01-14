# coding: utf-8

class Node
  include Mongoid::Document
  include Redis::Search

  key :title

  # Fields:
  field :title
  field :posts_count, :type => Integer, :default => 0

  # References
  references_many :posts

  field :follower_ids, :type => Array, :default => []

  # Scope
  default_scope :order => 'create at'
  scope :hot, desc(:comments_count, :posts_count)

  # Redis Search
  redis_search_index(:title_field => :title,
                     :score_field => :title,
                     :ext_field => :posts_count)


  # Validation
  validates_presence_of :title
  validates_uniqueness_of :title

  def push_follower(user_id)
    user = User.find(user_id)
    self.follower_ids << user.id if !self.follower_ids.include?(user.id)
    user.node_ids << self.id if !user.node_ids.include?(self.id)
    user.save! and self.save!
  end

  def pull_follower(user_id)
    self.follower_ids.delete(user_id)
    user = User.find(user_id)
    user.node_ids.delete(self.id)
  end

end
