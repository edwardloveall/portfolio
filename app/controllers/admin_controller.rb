class AdminController < ApplicationController
  include Monban::ControllerHelpers
  before_action :require_login
  layout 'admin'
end
