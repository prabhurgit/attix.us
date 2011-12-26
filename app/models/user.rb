# coding: utf-8
class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # fields
  field :name
  key :name

  field :posts_count, :type => Integer, :default => 0
  field :comments_count, :type => Integer, :default => 0

  validates :name, :length => {:in => 3..20}, :presence => true, :uniqueness => {:case_sensitive => true}

  scope :hot, desc(:comments_count, :posts_count)

  # References
  has_many :posts
  has_many :comments

  def admin?
    APP_CONFIG['admin_emails'].include? self.email
  end

end
