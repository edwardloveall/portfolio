Monban.configure do |config|
  config.no_login_redirect = { controller: 'admin/sessions', action: 'new' }
end
