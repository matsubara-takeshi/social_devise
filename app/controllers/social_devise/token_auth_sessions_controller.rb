module SocialDevise
  class TokenAuthSessionsController < DeviseTokenAuth::SessionsController
    skip_before_action :verify_authenticity_token
  end
end
