# frozen_string_literal: true

$LOAD_PATH.unshift File.join(__dir__, "lib")

require "dyno_metadata"

Gem::Specification.new do |s|
  s.name        = "dyno_metadata"
  s.version     = DynoMetadata::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Patrik Ragnarsson"]
  s.email       = ["patrik@starkast.net"]
  s.homepage    = "http://github.com/dentarg/dyno_metadata"
  s.summary     = "Information about the app and environment on Heroku."
  s.description = "Gives easy access to details about the release, dyno size,
                  application name as well as the unique identifier for the
                  particular running dyno."
  s.license     = "MIT"
  s.required_ruby_version = ">= 1.9.3"

  s.add_development_dependency "rake", "~> 11"
  s.add_development_dependency "rspec", "~> 3"
  s.add_development_dependency "rubocop", "~> 0.46"

  s.files        = Dir.glob("{lib}/**/*") + %w(README.md)
  s.require_path = "lib"
end
