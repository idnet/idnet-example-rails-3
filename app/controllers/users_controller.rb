class UsersController < ApplicationController
  class Client
    def initialize(url, app_id, format = :json)
      @url = url
      @app_id = app_id
      @format = format
    end

    def connection
      @connection ||= Faraday.new url: @url do |builder|
        builder.request  :url_encoded 
        builder.response :oj, content_type: /\bjson$/
        builder.use :instrumentation
        builder.adapter Faraday.default_adapter
      end
    end

    def post(path, options={})
      request(:post, path, options)
    end

    def get(path, options={})
      request(:get, path, options)
    end

    private
    def request(action, path, options = {})
      options[:client_id] ||= @app_id
      options[:format] ||= @format
      response = connection.send(action, path, options)
      response
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @hsign = HSign::Digest.new(APP_CONFIG[:app_secret])
    @hsign.sign(params.slice(:email, :password).merge(timestamp: Time.now.to_i))
    client = Client.new APP_CONFIG[:id_net_url], APP_CONFIG[:app_id]
    opts = @hsign.params.dup
    opts.merge!(params.slice(:meta))
    opts.merge!(client_id: APP_CONFIG[:app_id])
    idnet_response = client.post 'api/v1/json/accounts', opts
    if idnet_response.status.in? 200...300
      @user.create_with_idnet_api(idnet_response.body)
      session[:user_id] = @user.id
      redirect_to root_path
    elsif idnet_response.status.in? 400...500
      @errors = idnet_response.body
      render :new
    else
      @errors = {
        'error' => 'a server error occured on id.net',
        'details' => [{'ID.net server error' => idnet_response.body}]
      }
      render :new
    end
  end
end
