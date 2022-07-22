Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Chrome::Options.new(
    args: %w(headless disable-gpu)
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: capabilities
  )
end

Capybara.configure do |config|
  config.app_host = "http://lvh.me:8080"
  config.always_include_port = true
  config.javascript_driver = :headless_chrome
  config.server_host = "lvh.me"
  config.server_port = "8080"
end
