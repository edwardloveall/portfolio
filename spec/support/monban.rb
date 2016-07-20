Monban.test_mode!

RSpec.configure do |config|
  config.include Monban::Test::Helpers, type: :feature
  config.include Monban::Test::ControllerHelpers, type: :controller

  config.after :each do
    Monban.test_reset!
  end
end
