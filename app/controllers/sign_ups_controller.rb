class SignUpsController < ApplicationController
  unauthenticated_access_only
  rate_limit to: 10, within: 3.minutes, only: :create,
    with: -> { redirect_to sign_up_path, alert: "Try again later!" }
  def show
    @user = User.new
  end

  def create
    begin
      @user = User.new(sign_up_params)
      if @user.save
        start_new_session_for(@user)
        redirect_to root_path
      else
        render :show, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render :show, status: :conflict, alert: e.message
    end
  end

  private

  def sign_up_params
    params.expect(user: [ :first_name, :last_name, :password, :password_confirmation, :email_address ])
  end
end
