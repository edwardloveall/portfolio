class TokensController < ApplicationController
  def create
    authorization = Authorization.not_code_expired.find_by(
      code: params[:code],
      client_id: params[:client_id]
    )
    if authorization.present?
      authorization.generate_token!
      respond_to do |format|
        format.json { render json: reply(authorization) }
        format.url_encoded_form {
          render plain: form_encoded_response(authorization)
        }
      end
    end
  end

  private

  def reply(authorization)
    {
      me: authorization.me,
      access_token: authorization.token,
      scope: authorization.scope
    }
  end

  def form_encoded_response(authorization)
    URI.encode_www_form(reply(authorization))
  end
end
