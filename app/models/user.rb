class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true

  def self.build_from_github(hash)
    @new_user = User.new
    @new_user.email = hash[:info][:email]
    @new_user.uid = hash[:uid]
    @new_user.name = hash[:info][:name]
    @new_user.username = hash[:info][:nickname]
    @new_user.provider = hash[:provider]
    @new_user.save
  end
end
