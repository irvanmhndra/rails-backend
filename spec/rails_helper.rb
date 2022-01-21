# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'

require 'jsonapi/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each do |f|
  require f
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.include JSONAPI::RSpec

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
