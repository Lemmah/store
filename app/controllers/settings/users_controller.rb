class Settings::UsersController < ApplicationController
  def destroy
    terminate_session
    Current.user.destroy
    redirect_to root_path, notice: "Your account has been deleted.", status: :see_other
  end
end
