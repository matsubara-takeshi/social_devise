module SocialDevise
  class Profile < ActiveRecord::Base
    belongs_to :user

    validates :uid, uniqueness: { scope: :provider }

    validate :another_profile_presence, on: :destroy

    def self.fetch(auth_hash)
      profile = find_or_initialize_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
      profile.attributes = auth_hash
      profile
    end

    private

    def another_profile_presence
      errors.add(:base, '外部サービス連携は最低1件必要です') unless user.social_profiles.count > 1
    end
  end
end
