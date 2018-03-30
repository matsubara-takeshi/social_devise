module SocialDevise
  class Profile < ActiveRecord::Base
    belongs_to :user # TODO: Be resource_class of Devise
    store :other

    validates :uid, uniqueness: { scope: :provider }

    validate :another_profile_presence, on: :destroy

    def self.fetch(attributes)
      profile = find_or_initialize_by(uid: attributes[:uid], provider: attributes[:provider])
      profile.to_resource
      profile.update!(attributes)
      profile
    end

    def to_resource
      self.user = User.find_or_initialize_by(uid: uid, provider: provider) unless user
      user
    end

    def user!(user)
      self.user ||= user
      save!
    end

    private

    def another_profile_presence
      errors.add(:base, '外部サービス連携は最低1件必要です') unless user.social_profiles.count > 1
    end
  end
end
