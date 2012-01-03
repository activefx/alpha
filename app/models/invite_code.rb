class InviteCode
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, :type => String
  field :invitation_sent_to, :type => String
  field :invitation_sent_at, :type => DateTime
  field :invitation_accepted_at, :type => DateTime

  attr_accessible :invitation_sent_to

  validates :token, :presence => true, :uniqueness => true

  before_validation(:on => :create) do |document|
    document.generate_invitation_token
  end

  index :token, :unique => true

  protected

  def generate_invitation_token
    self.token = Devise.friendly_token
  end

end

