require "net/http"

class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:private_data]
  def index
  end

  def private_data
    json = access_token.get('/api/profile')
    render text: json.as_json, layout: true
  end

  def activities
    uri = URI.parse("#{APP_CONFIG[:id_net_url]}/api/v1/json/activities?app_id=#{APP_CONFIG[:app_id]}&app_key=main")
    http = Net::HTTP.new(uri.host, uri.port)
    @activities = JSON.parse(http.request(Net::HTTP::Get.new(uri.request_uri)).body)
  end

  def activity
    result = JSON.parse(access_token.post('/api/v1/json/activity', {body: {activity: params[:activity]}}).body)
    if result["activity"]["errors"].present?
      flash[:error] = ""
      result["activity"]["errors"].each do |error|
        flash[:error] += "<p>#{error}</p>"
      end
    else
      flash[:notice] = "Your comment is successfully saved"
    end
    redirect_to :activities
  end
end
