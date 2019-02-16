require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of :username}
    it {should validate_presence_of :street}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip_code}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password_digest}
    it {should validate_uniqueness_of :email}
  end

  describe 'realationships' do
    it {should have_many :orders}
    it {should have_many :items}
  end
end
