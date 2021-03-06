class Admin::SessionsController < AdminController
  skip_before_action :require_login, only: [:new, :create], raise: false

  def new
  end

  def create
    user = authenticate_session(session_params)
    destination = session.delete(:original_path) || admin_projects_path

    if sign_in(user)
      redirect_to destination
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
