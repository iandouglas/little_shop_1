require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'validations' do
  end

  describe 'realationships' do
    it {should belong_to :user}
  end
end
