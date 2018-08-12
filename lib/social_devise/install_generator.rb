require 'rails/generators/active_record'

module SocialDevise
  class InstallGenerator < ::Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('./templates', __dir__)
    desc 'Installs SocialDevise migration file.'

    def install
      migration_template(
        'migration.rb.erb',
        'db/migrate/create_social_devise_tables.rb',
        migration_version: migration_version
      )
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

    private

    def migration_version
      if ActiveRecord::VERSION::MAJOR >= 5
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
