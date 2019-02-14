FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    sequence(:password) { "password" }
    sequence(:username) { |n| "User Name #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip_code) { |n| "Zip #{n}" }
    role { 0 }
    enabled { 0 }
  end
  factory :inactive_user, parent: :user do
    sequence(:username) { |n| "Inactive User Name #{n}" }
    sequence(:email) { |n| "inactive_user_#{n}@gmail.com" }
    enabled { 1 }
  end

  factory :merchant, parent: :user do
    sequence(:email) { |n| "merchant_#{n}@gmail.com" }
    sequence(:username) { |n| "Merchant Name #{n}" }
    role { 1 }
    enabled { 0 }
  end
  factory :inactive_merchant, parent: :user do
    sequence(:email) { |n| "inactive_merchant_#{n}@gmail.com" }
    sequence(:username) { |n| "Inactive Merchant Name #{n}" }
    role { 1 }
    enabled { 1 }
  end

  factory :admin, parent: :user do
    sequence(:email) { |n| "admin_#{n}@gmail.com" }
    sequence(:username) { |n| "Admin Name #{n}" }
    role { 2 }
    enabled { 0 }
  end
end
