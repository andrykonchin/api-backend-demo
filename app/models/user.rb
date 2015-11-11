class User < ActiveRecord::Base
  has_many :device_sessions

  validates :email, presence: true
end
