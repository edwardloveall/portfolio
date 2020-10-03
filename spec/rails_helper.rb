ENV['RAILS_ENV'] = 'test'

require 'selenium/webdriver'

require File.expand_path('../../config/environment', __FILE__)
abort('DATABASE_URL environment variable is set') if ENV['DATABASE_URL']

include ActionDispatch::TestProcess

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    default_url_options[:host] = 'http://lvh.me'
    default_url_options[:port] = 8080
  end
  config.include Features, type: :feature
  config.include ForgeryProtectionHelper, type: :request
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.include ActiveSupport::Testing::TimeHelpers

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end

ActiveRecord::Migration.maintain_test_schema!
WebMock.disable_net_connect!(allow_localhost: true)
