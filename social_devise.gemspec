$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social_devise/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social_devise"
  s.version     = SocialDevise::VERSION
  s.authors     = ["kawamura.hryk"]
  s.email       = ["kawamura.hryk@gmail.com"]
  s.homepage    = "https://github.com/dqnch/social_devise"
  s.summary     = "Makes Devise support social profiles."
  s.description = "Makes Devise support social profiles."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"
  s.add_dependency "devise"

  s.add_development_dependency "sqlite3"
end
