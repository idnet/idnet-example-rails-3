require 'net/http'

class AppRequestsController < ApplicationController
  def index
    @application_requests = JSON.parse(access_token.get("/api/v1/json/application_requests/#{current_user.uid}").body)
  end
end
