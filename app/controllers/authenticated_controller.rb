class AuthenticatedController < ApplicationController
  include Monban::ControllerHelpers
  before_action :require_login

  def require_login
    if !signed_in?
      flash.notice = Monban.config.sign_in_notice.call
      session[:original_path] = request.original_fullpath

      redirect_to Monban.config.no_login_redirect
    end
  end
end
