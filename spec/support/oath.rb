Oath.test_mode!

RSpec.configure do |config|
  config.include Oath::Test::Helpers, type: :feature
  config.include Oath::Test::ControllerHelpers, type: :controller

  config.after :each do
    Oath.test_reset!
  end
end
