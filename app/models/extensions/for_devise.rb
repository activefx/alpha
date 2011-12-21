module Extensions
  module ForDevise
    extend ActiveSupport::Concern

    included do

      # Define instance and class methods to determine if a model
      # is equipped with a specific devise component
      Devise::ALL.each do |method_name|
        # Define class methods
        define_singleton_method(:"#{method_name}?") { deviseable?(method_name) }
        # Define instance methods
        define_method(:"#{method_name}?") { deviseable?(method_name) }
      end

      # Define Mongoid indexes for Devise
      index :email,               unique: true if database_authenticatable?
      index :confirmation_token,  unique: true if confirmable?
      index :unlock_token,        unique: true if has_unlock_token?

    end

    module ClassMethods

      protected

      def deviseable?(method_name)
        devise_modules.include?(method_name)
      end

      def has_unlock_token?
        lockable? && unlock_strategy_includes_token?
      end

      def unlock_strategy_includes_token?
        [:both, :email].include?(unlock_strategy)
      end

    end

    # Instance Methods

    protected

    def deviseable?(method_name)
      devise_modules.include?(method_name)
    end


  end
end

