class Api::MicropubsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    micropost = Micropost.create(body: params[:content])
    head :created, location: micropost_url(micropost)
  end
end
