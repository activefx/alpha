load "#{Rails.root}/app/models/user.rb"

FactoryGirl.define do
  factory :user, :class => User do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    if User.confirmable?
      confirmed_at Time.now.utc
    end
  end
end

