class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :sign_in_user, :signed_in?, :current_user, :add_error

  before_filter :verify_signed_in

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in_user(user)
    @user.session_token = @user.reset_token
    session[:token] = @user.session_token
    @user.save
    @current_user = @user
    add_notice("Welcome #{user.display_name}!")
  end

  def sign_out
    user = current_user
    user.reset_token
    session[:token] = nil
  end

  def verify_signed_in
    redirect_to new_user_url unless signed_in?
  end

  def add_error(error)
    flash[:errors] ||= []
    flash[:errors] << error
  end

  def add_notice(notice)
    flash[:notices] ||= []
    flash[:notices] << notice
  end
end
