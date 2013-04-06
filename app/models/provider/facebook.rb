module Provider
  class Facebook < Provider::Base

    class << self

      def attributes(omniauth)
        super.merge({
          'username' => omniauth.info.email,
          'email' => omniauth.info.email,
          'name' => omniauth.info.name,
          'image_url' => omniauth.info.image,
          'first_name' => omniauth.extra.try(:raw_info).try(:first_name),
          'last_name' => omniauth.extra.try(:raw_info).try(:last_name),
          'facebook_identifier' => omniauth.extra.try(:raw_info).try(:id),
          'facebook_link' => omniauth.extra.try(:raw_info).try(:link),
          'facebook_location_name' => omniauth.extra.try(:raw_info).try(:location).try(:name),
          'facebook_location_id' => omniauth.extra.try(:raw_info).try(:location).try(:id)
        })
      end

    end

  end
end

