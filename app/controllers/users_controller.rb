class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Benutzer erfolgreich aktualisiert.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Benutzer erfolgreich gelöscht.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: 'Zugriff verweigert!'
    end
  end
end
