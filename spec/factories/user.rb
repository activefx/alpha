load "#{Rails.root}/app/models/user.rb"

FactoryGirl.define do
  factory :user, :class => User do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'
    after_create do |user|
      user.confirm! if user.confirmable?
    end
  end
end

