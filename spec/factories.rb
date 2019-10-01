FactoryBot.define do
  factory :page do
  end

  factory :sitemap_file do
  end

  factory :site do
    sequence(:domain) { |n| "domain#{n}@test.com" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:password) { |n| "password#{n}" }
    sequence(:password_confirmation) { |n| "password#{n}" }
  end
end
