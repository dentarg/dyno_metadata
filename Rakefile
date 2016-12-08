# frozen_string_literal: true

# Bundler rake tasks to handle gem releases
require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  warn "Could not require RSpec gem"
end

begin
  require "rubocop/rake_task"

  desc "Run RuboCop on the lib directory"
  RuboCop::RakeTask.new(:rubocop)
rescue LoadError
  warn "Rakefile could not require RuboCop gem"
end

task default: [:spec, :rubocop]
