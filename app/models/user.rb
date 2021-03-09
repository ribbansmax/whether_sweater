class User < ApplicationRecord
  before_create :set_api
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, required: true
  has_secure_password

  def set_api
    self.api_key = SecureRandom.uuid
  end
end
