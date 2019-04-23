$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "darp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "darp"
  spec.version     = Darp::VERSION
  spec.authors     = ["Esben Damgaard", "Thies Pierdola"]
  spec.email       = ["ebbe@hvemder.dk"]
  spec.summary     = "Delayd Async Request Processing"
  spec.description = "Description of Darp."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.0"
  spec.add_development_dependency "sqlite3", '~> 1.3.0'
end
