require 'net/http'
class ActivitiesController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def index
    uri = URI.parse("#{APP_CONFIG[:id_net_url]}/api/v1/json/activities?app_id=#{APP_CONFIG[:app_id]}&app_namespace=main&page=#{params[:page]||1}")
    http = Net::HTTP.new(uri.host, uri.port)
    result = JSON.parse(http.request(Net::HTTP::Get.new(uri.request_uri)).body)
    @page = result["page"]
    @pages_count = result["pages_count"]
    @activities = result["results"]
    @users = User.where(uid: @activities.map{|a| a['author_pid']}).index_by(&:uid)
  end

  def create
    result = JSON.parse(access_token.post('/api/v1/json/activities', {body: {app_id: APP_CONFIG[:app_id], activity: activity_params}}).body)
    if result["errors"].present?
      flash[:error] = ""
      result["errors"].each do |error|
        flash[:error] += "<p>#{error}</p>"
      end
    else
      flash[:notice] = "Your comment is successfully saved"
    end
    redirect_to :activities
  end

  private
  def activity_params
    params[:activity] ||= {}
    params[:activity].merge!(url: 'http://localhost:9292/activities')
  end
end
