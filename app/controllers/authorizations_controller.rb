class AuthorizationsController < AuthenticatedController
  def new
    @authorization = Authorization.new(
      client_id: params[:client_id],
      scope: params[:scope]
    )
  end

  def create
    if auth = current_user.authorizations.create(authorization_params)
      callback = params[:redirect_uri]
      callback_params = URI.encode_www_form(
        state: params[:state],
        code: auth.code
      )

      redirect_to "#{callback}?#{callback_params}"
    end
  end

  private

  def authorization_params
    params.require(:authorization).permit(:client_id, :scope)
  end
end
