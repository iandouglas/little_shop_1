class User < ApplicationRecord

  validates_presence_of :username, :street, :city, :state, :zip_code, :email, :password
  validates_uniqueness_of :username, :email
end
