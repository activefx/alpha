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

    end

    module ClassMethods

      protected

      def deviseable?(method_name)
        devise_modules.include?(method_name)
      end

    end

    # Instance Methods

    protected

    def deviseable?(method_name)
      devise_modules.include?(method_name)
    end


  end
end
