class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username, :street, :city, :state, :zip_code, :email, :password_digest
  validates_uniqueness_of :email

  has_many :orders
  has_many :items
  enum role: ['user', 'merchant', 'admin']
  enum enabled: ['enabled', 'disabled']

  def top_items_for_merchant(limit)
    items.joins(:order_items)
    .select("items.*, sum(order_items.quantity) as total_quan")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("total_quan desc")
    .group(:id)
    .limit(limit)
  end

end
