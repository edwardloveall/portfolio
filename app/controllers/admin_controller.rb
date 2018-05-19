class AdminController < ApplicationController
  include Monban::ControllerHelpers
  before_action :require_login
  layout 'admin'

  def require_login
    if !signed_in?
      flash.notice = Monban.config.sign_in_notice.call
      original_path = url_for(params.to_h.merge(only_path: true))

      redirect_to(
        Monban.config.no_login_redirect.merge(original_path: original_path)
      )
    end
  end
end
