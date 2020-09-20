require Rails.root.join('config/smtp')
Rails.application.configure do
  config.action_controller.perform_caching = true
  config.action_controller.asset_host = ENV.fetch('ASSET_HOST',
                                                  ENV.fetch('APPLICATION_HOST'))
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = {
    host: ENV.fetch('APPLICATION_HOST'),
  }
  config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.active_record.dump_schema_after_migration = false
  config.active_storage.service = :local
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.digest = true
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.hosts << ENV.fetch('APPLICATION_HOST')
  config.hosts << ENV.fetch('BLOG_HOST')
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :debug
  config.middleware.use Rack::Deflater
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
end
