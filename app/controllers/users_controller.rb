class UsersController < ApplicationController
  skip_before_action :check_jwt_for_current_user, only: [:api_sign_in, :api_sign_out]
  respond_to :json

  def check_signed_in
    render json: { success: true }
  end

  def api_sign_in
    user = User.find_by_email(params[:user][:email])
    if user.valid_password?(params[:user][:password])
      cookies[:user_jwt] = { value: user.generate_jwt, http_only: true }
      render json: { success: true }
    else
      render json: { success: false }, status: :unauthorized
    end
  end
  def api_sign_out
    reset_session
    cookies.delete(:user_jwt)
    render json: { success: true, status: :unauthorized }
  end
end
