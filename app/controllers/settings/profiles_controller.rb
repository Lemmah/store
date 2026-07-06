class Settings::ProfilesController < Settings::BaseController
  before_action :set_user
  def show
  end
  def edit
  end

  def update
    if @user.update(edit_profile_params)
      redirect_to settings_profile_path,
        status: :see_other,
        notice: "Your profile was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def edit_profile_params
    params.expect(user: [ :first_name, :last_name, :email_address ])
  end
end
