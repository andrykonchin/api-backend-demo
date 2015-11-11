class DeviceSession < ActiveRecord::Base
  belongs_to :user

  validates :authentication_token, presence: true
end
