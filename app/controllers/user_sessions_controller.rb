class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path
    else
      # Rails.logger.warn("Login attempt failed: Invalid email or password for email #{params[:email]}")
      # render :new
      redirect_to action: :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
