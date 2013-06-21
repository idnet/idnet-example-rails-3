class SessionsController < ApplicationController

  def new
    redirect_to '/auth/idnet'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:uid => auth['uid'].to_s).first || User.new
    user.update_with_omniauth!(auth)
    session[:user_id] = user.id
    flash[:notice] = 'Signed in!'
    if params[:iframe].present?
      flash.keep
      render
    else
      redirect_to params[:bounce].presence || root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  def setup
    strategy = request.env['omniauth.strategy']
    uri = URI.parse(strategy.callback_url)
    uri.query = "#{uri.query.nil? ? '' : uri.query + '&'}bounce=/activities"
    strategy.options[:callback_path] = uri.path + '?' + uri.query.to_s
    render :text => "Omniauth setup phase.", :status => 404
  end

end
