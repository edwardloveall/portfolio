class TokensController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    authorization = Authorization.not_code_expired.find_by(
      code: params[:code],
      client_id: params[:client_id]
    )
    if authorization.present?
      authorization.generate_token!
      respond_to do |format|
        format.json { render json: creation_reply(authorization) }
        format.url_encoded_form {
          render plain: URI.encode_www_form(creation_reply(authorization))
        }
      end
    end
  end

  def verify
    authorization = Authorization.not_token_expired.find_by(
      token: request.headers["Authorization"].sub("Bearer ", "")
    )
    if authorization.present?
      respond_to do |format|
        format.json { render json: verification_reply(authorization) }
        format.url_encoded_form do
          render plain: URI.encode_www_form(verification_reply(authorization))
        end
      end
    end
  end

  private

  def creation_reply(authorization)
    {
      me: authorization.me,
      access_token: authorization.token,
      scope: authorization.scope
    }
  end

  def verification_reply(authorization)
    {
      me: authorization.me,
      client_id: authorization.client_id,
      scope: authorization.scope
    }
  end
end
