module Extensions
  module Validatable
    extend ActiveSupport::Concern

    included do

      # Options
      #  email_regexp:
      #    The regular expression used to validate e-mails;
      #  password_length:
      #    A range expressing password length. Defaults to 8..128.
      #
      devise :validatable

    end

  end
end 
