FactoryBot.define do
  factory :page do
    
  end

  factory :sitemap_file do
    
  end

  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
  end
end
