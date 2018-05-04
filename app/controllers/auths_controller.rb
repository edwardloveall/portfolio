class AuthsController < ApplicationController
  def show
    location = "#{params[:redirect_uri]}?state=#{params[:state]}&code=123"
    redirect_to location
  end
end
