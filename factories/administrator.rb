load "#{Rails.root}/app/models/administrator.rb"

FactoryGirl.define do
  factory :admin, :class => Administrator do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password "password"
    password_confirmation "password"
    if Administrator.confirmable?
      confirmed_at Time.now.utc
    end
  end
end

