FactoryBot.define do
  factory :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:thumbnail) { |n| "https://picsum.photos/200/300?image=#{n}" }
    sequence(:price) { |n| ("#{n}".to_i+1)*1.5 }
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
    enabled { 0 }
  end

  factory :inactive_item, parent: :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Inactive Item Name #{n}" }
    enabled { 1 }

  end
end
