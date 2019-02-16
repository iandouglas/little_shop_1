FactoryBot.define do
  factory :order_item do
    order
    item
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
    sequence(:current_price) { |n| ("#{n}".to_i+1)*1.5 }
    fulfilled { 0 }
  end
  factory :fulfilled_order_item, parent: :order_item do
    fulfilled { 1 }
  end
end
