load "#{Rails.root}/app/models/administrator.rb"

FactoryGirl.define do
  factory :admin, :class => Administrator do
    email 'admin@example.com'
    password 'password'
    password_confirmation 'password'
    after_create do |admin|
      admin.confirm! if admin.confirmable?
    end
  end
end

