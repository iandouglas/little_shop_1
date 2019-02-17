class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username, :street, :city, :state, :zip_code, :email, :password_digest
  validates_uniqueness_of :email

  has_many :orders
  has_many :items
  enum role: ['user', 'merchant', 'admin']
end
