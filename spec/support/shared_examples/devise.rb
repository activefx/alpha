shared_examples_for "a devise model" do

  Devise::ALL.each do |devise_module|

    it "responds to #{devise_module}? class method" do
      subject.class.respond_to?(:"#{devise_module}?").should be_true
    end

    it "responds to #{devise_module}? instance method" do
      subject.respond_to?(:"#{devise_module}?").should be_true
    end

  end

  # confirmable

  if subject.call.confirmable?
    it { should have_field(:confirmation_token).of_type(String) }
    it { should_not allow_mass_assignment_of(:confirmation_token => "token") }
    it { should have_index_for(:confirmation_token).with_options(:unique => true) }
    it { should have_field(:confirmed_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:confirmed_at => Time.now) }
    it { should have_field(:confirmation_sent_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:confirmation_sent_at => Time.now) }
  end

  # database_authenticatable

  if subject.call.database_authenticatable?
    it { should have_field(:email).of_type(String).with_default_value_of("") }
    it { should have_index_for(:email).with_options(:unique => true) }
    it { should have_field(:encrypted_password).of_type(String).with_default_value_of("") }
    it { should_not allow_mass_assignment_of(:encrypted_password => "encrypted_password") }
  end

  # encryptable

  if subject.call.encryptable?
    it { should have_field(:password_salt).of_type(String) }
    it { should_not allow_mass_assignment_of(:password_salt => "password_salt") }
  end

  # lockable

  if subject.call.lockable?
    if subject.call.class.lock_strategy == :failed_attempts
      it { should have_field(:failed_attempts).of_type(Integer).with_default_value_of(0) }
      it { should_not allow_mass_assignment_of(:failed_attempts => 1) }
    end
    if [:both, :email].include?(subject.call.class.unlock_strategy)
      it { should have_field(:unlock_token).of_type(String) }
      it { should_not allow_mass_assignment_of(:unlock_token => "unlock_token") }
      it { should have_index_for(:unlock_token).with_options(:unique => true) }
    end
    it { should have_field(:locked_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:locked_at => Time.now) }
  end

  # recoverable

  if subject.call.recoverable?
    it { should have_field(:reset_password_token).of_type(String) }
    it { should_not allow_mass_assignment_of(:reset_password_token => "reset_password_token") }
    if Devise.reset_password_within.present?
      it { should have_field(:reset_password_sent_at).of_type(Time) }
      it { should_not allow_mass_assignment_of(:reset_password_sent_at => Time.now) }
    end
  end

  # rememberable

  if subject.call.rememberable?
    unless Devise.use_salt_as_remember_token
      it { should have_field(:remember_token).of_type(String) }
      it { should_not allow_mass_assignment_of(:remember_token => "remember_token") }
    end
    it { should have_field(:remember_created_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:remember_created_at => Time.now) }
  end

  # token_authenticatable

  if subject.call.token_authenticatable?
    it { should have_field(:authentication_token).of_type(String) }
    it { should_not allow_mass_assignment_of(:authentication_token => "authentication_token") }
  end

  # trackable

  if subject.call.trackable?
    it { should have_field(:sign_in_count).of_type(Integer).with_default_value_of(0) }
    it { should_not allow_mass_assignment_of(:sign_in_count => 1) }
    it { should have_field(:current_sign_in_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:current_sign_in_at => Time.now) }
    it { should have_field(:last_sign_in_at).of_type(Time) }
    it { should_not allow_mass_assignment_of(:last_sign_in_at => Time.now) }
    it { should have_field(:current_sign_in_ip).of_type(String) }
    it { should_not allow_mass_assignment_of(:current_sign_in_ip => "current_sign_in_ip") }
    it { should have_field(:last_sign_in_ip).of_type(String) }
    it { should_not allow_mass_assignment_of(:last_sign_in_ip => "last_sign_in_ip") }
  end

  # validatable

  if subject.call.validatable?
    if subject.call.database_authenticatable?
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_format_of(:email) }
      it { should validate_presence_of(:password) }
      it { should validate_confirmation_of(:password) }
      it { should validate_length_of(:password).within(subject.class.password_length) }
    end
  end

end

