class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Extensions::DatabaseAuthenticatable
  include Extensions::Confirmable
  include Extensions::Lockable
  include Extensions::Recoverable
  include Extensions::Registerable
  include Extensions::Rememberable
  include Extensions::Timeoutable
  include Extensions::TokenAuthenticatable
  include Extensions::Trackable
  include Extensions::Validatable
  include Extensions::Omniauthable
  include Extensions::DeviseHelpers
  if BACKGROUND_WORKERS_AVAILABLE
    include Extensions::Async
  end

  # User Details
  field :username,                    type: String
  field :name,                        type: String
  field :company,                     type: String
  # Stripe
  field :customer_id,                 type: String
  field :last_4_digits,               type: String
  # API
  field :monthly_api_rate_limit,      type: Integer
  field :daily_api_rate_limit,        type: Integer
  field :hourly_api_rate_limit,       type: Integer

  attr_accessor :stripe_token

  attr_accessible :username, :name, :company, :stripe_token

  embeds_many :api_keys, :validate => true

  index({ 'api_keys.token' => 1 }, { unique: true })

  rolify

  def create_api_key
    api_keys.create
  end

  def create_stripe_customer
    Stripe::Customer.create(
      :email => email,
      :description => name,
      :card => stripe_token,
      :plan => roles.first.name
    )
  end

  def stripe_customer
    Stripe::Customer.retrieve(customer_id)
  end

  protected

  def self.search(search = nil, page = 1)
    unless search.blank?
      where(:email => /#{Regexp.quote(search)}/).page(page).per(10)
    else
      page(page).per(10)
    end
  end

  # # listSubscribe
  # #   string apikey
  # #   string id
  # #   string email_address
  # #   array merge_vars
  # #   string email_type
  # #   bool double_optin
  # #   bool update_existing
  # #   bool replace_interests,
  # #   bool send_welcome
  # def add_user_to_mailchimp_subscribers
  #   unless self.email.include?('@example.com')
  #     mailchimp = Hominid::API.new(configatron.mailchimp.api_key)
  #     list_id = mailchimp.find_list_id_by_name "Alpha Subscriber"
  #     info = { }
  #     result = mailchimp.list_subscribe(list_id, self.email, info, 'html', false, true, false, true)
  #     Rails.logger.info("MAILCHIMP SUBSCRIBE: result #{result.inspect} for #{self.email}")
  #   end
  # end

  # # listUnsubscribe
  # #   string apikey
  # #   string id
  # #   string email_address
  # #   boolean delete_member
  # #   boolean send_goodbye
  # #   boolean send_notify
  # def remove_user_from_mailchimp_subscribers
  #   unless self.email.include?('@example.com')
  #     mailchimp = Hominid::API.new(configatron.mailchimp.api_key)
  #     list_id = mailchimp.find_list_id_by_name "Alpha Subscriber"
  #     result = mailchimp.list_unsubscribe(list_id, self.email, true, false, false)
  #     Rails.logger.info("MAILCHIMP UNSUBSCRIBE: result #{result.inspect} for #{self.email}")
  #   end
  # end

end
