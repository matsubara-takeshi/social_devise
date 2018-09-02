module SocialDevise
  class OmniauthCallbacksController < ApplicationController
    def callback_for_providers
      profile = profile_class.fetch(OmniauthResource.factory(request.env['omniauth.auth']).to_h)
      if signed_in? # Already signed in with another Social Login
        # TODO: Implement
        # profile.user ||= current_user
        # profile.save!
        # redirect_to ...
      elsif profile.user_id? # Registered user
        sign_in(:user, profile.user)
        flash[:notice] = 'You have signed in.'
      else # Unregistered user
        register!(profile)
        flash[:alert] = 'You have registered and signed in.'
      end
      redirect_to after_sign_in_path_for(:user)
    end
    alias github callback_for_providers
    alias doorkeeper callback_for_providers

    def failure
      redirect_to root_path
    end

    # TODO: Refactor!
    def register!(profile)
      user = profile.to_resource
      user.email = profile.email
      user.save!(validate: false)
      profile.update!(user: user)
      sign_in(:user, user)
    end

    protected

    def profile_class
      Profile
    rescue NameError
      SocialDevise::Profile
    end
  end
end
