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

  def top_states_for_merchant(limit)
    items.joins(order_items: [{order: :user}])
    .select("users.state, sum(order_items.quantity) as quantity")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("quantity desc")
    .group(:state)
    .limit(limit)
  end

  def top_cities_for_merchant(limit)
    items.joins(order_items: [{order: :user}])
    .select("users.state, city, sum(order_items.quantity) as quantity")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("quantity desc")
    .group(:city, :state)
    .limit(limit)
  end

  def top_user_by_orders(limit)
    items.joins(order_items: [{order: :user}])
    .select("users.username, count(distinct orders.id) as quantity")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("quantity desc")
    .group(:username)
    .limit(limit)
  end

  def top_user_by_items(limit)
    items.joins(order_items: [{order: :user}])
    .select("users.username, sum(order_items.quantity) as quantity")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("quantity desc")
    .group(:username)
    .limit(limit)
  end

  def top_users_by_price(limit)
    items.joins(order_items: [{order: :user}])
    .select("users.username, sum(order_items.current_price * order_items.quantity) as money_spent")
    .where(order_items: {fulfilled: 1}, enabled: :enabled)
    .order("money_spent desc")
    .group(:username)
    .limit(limit)
  end

  def self.top_merchants_by_price_and_qty
    self.joins(items: :order_items)
    .select("users.username, sum(order_items.current_price * order_items.quantity) as revenue, sum(order_items.quantity) as total_items")
    .where(order_items: {fulfilled:1}, enabled: :enabled)
    .order("revenue desc")
    .group(:username)
    .limit(3)
  end

  # def self.fulfillment_times(order)
  #   self.joins(items: :order_items)
  #   .select("users.username, avg(order_items.updated_at - order_items.created_at) as fulfill_time")
  #   .where(order_items: {fulfilled: 1}, enabled: :enabled)
  #   .order("fulfill_time ?", order.upcase)
  #   .group("users.username")
  #   limit(3)
  # end

  def self.top_shipped_states
    self.joins(:orders)
    .select("users.state, count(users.state) as state_count")
    .where(orders: {status: 1})
    .order("state_count DESC")
    .group("users.state")
    .limit(3)
  end

  def self.top_shipped_cities
    self.joins(:orders)
    .select("users.city, count(users.city) as city_count, users.state")
    .where(orders: {status: 1})
    .order("city_count DESC, users.state ASC")
    .group("users.city, users.state")
    .limit(3)
  end
end
