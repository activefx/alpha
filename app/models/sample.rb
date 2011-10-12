class Sample
  include Mongoid::Document

  field :email
  field :password
  field :password_confirmation
  field :twitter_id
  field :agree
  field :spam
  field :spammer

end

