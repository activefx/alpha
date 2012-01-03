load "#{Rails.root}/app/models/invite_code.rb"

FactoryGirl.define do
  factory :invite_code, :class => InviteCode do
    invitation_sent_at { Time.now }
  end
end

