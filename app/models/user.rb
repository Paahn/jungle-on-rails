class User < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5 }

  has_secure_password
end
