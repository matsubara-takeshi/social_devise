module SocialDevise
  class TokenAuthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    def omniauth_success
      super do
        @auth_params.merge!(social_profile_id: @social_profile.id)
      end
    end

    protected

    def get_resource_from_auth_hash
      @social_profile = Profile.fetch(OmniauthResource.factory(auth_hash).to_h)
      if @social_profile.user
        @resource = @social_profile.user
        @social_profile.save!
      else
        @resource = resource_class.find_or_initialize_by(
          uid: auth_hash['uid'],
          provider: auth_hash['provider']
        )
        build_new_user if @resource.new_record?
        @resource.social_profiles << @social_profile
      end

      # @resource # これ多分不要なのだが `super` に合わせておく
    end

    private

    def build_new_user
      @oauth_registration = true if @resource.new_record?
      assign_provider_attrs(@resource, auth_hash)
      extra_params = whitelisted_params
      @resource.assign_attributes(extra_params) if extra_params
    end
  end
end
