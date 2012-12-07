class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Exception => e
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, :alert => "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
  end

  def access_token
    return @access_token if defined?(@access_token)
    consumer = OAuth2::Client.new(APP_CONFIG[:app_id], APP_CONFIG[:app_id], { 
      site: APP_CONFIG[:id_net_url],
      authorize_url: "#{APP_CONFIG[:id_net_url]}/oauth/authorize",
      access_token_url: "#{APP_CONFIG[:id_net_url]}/oauth/token"
    }
    )
    @access_token = OAuth2::AccessToken.from_hash(consumer, access_token: current_user.access_token, expires: current_user.token_expires,header_format: "OAuth %s", param_name: :oauth_token )
  end
end
