module Provider
  class Twitter < Provider::Base

    class << self

      def attributes(omniauth)
        super.merge 'username' => omniauth.info.nickname
      end

    end

  end
end 
