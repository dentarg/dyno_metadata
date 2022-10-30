# frozen_string_literal: true

require "climate_control"
require "securerandom"

RSpec.configure do |conf|
  conf.disable_monkey_patching!
  conf.filter_run :focus
  conf.order = :random
  conf.run_all_when_everything_filtered = true
  conf.warnings = true
end
