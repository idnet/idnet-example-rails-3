require 'net/http'

class AppRequestsController < ApplicationController
  def index
    @friends = JSON.parse(access_token.get("/api/v1/json/#{current_user.uid}/friends").body)["data"]
  end

  def callback
    obtain_token params[:code]
    @request = JSON.parse(access_token.get("/api/v1/json/request-#{params[:request_id]}_#{current_user.uid}").body)
  end

  def delete
    access_token.delete("/api/v1/json/request-#{params[:request_id]}_#{current_user.uid}")
    flash[:notice] = "Request successfully trashed"
    redirect_to root_path
  end
end
