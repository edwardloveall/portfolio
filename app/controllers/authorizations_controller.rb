class AuthorizationsController < AuthenticatedController
  def new
    @authorization = Authorization.new(authorization_params)
  end

  private

  def authorization_params
    {
      client_id: params[:client_id],
      scope: params[:scope]
    }
  end
end
