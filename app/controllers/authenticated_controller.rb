class AuthenticatedController < ApplicationController
  include Oath::ControllerHelpers
  before_action :require_login

  def require_login
    if !signed_in?
      flash.notice = Oath.config.sign_in_notice.call
      session[:original_path] = request.original_fullpath

      redirect_to Oath.config.no_login_redirect
    end
  end
end
