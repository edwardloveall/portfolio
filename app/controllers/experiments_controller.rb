class ExperimentsController < ApplicationController
  def index
    @objects = S3Client.objects
  end

  def show
    @objects = S3Client.objects(path: params[:path])
    render :index
  end
end
