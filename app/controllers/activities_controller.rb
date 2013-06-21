require 'net/http'
class ActivitiesController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def index
    hsign = HSign::Digest.new(APP_CONFIG[:app_secret])
    
    hsign.sign(app_id: APP_CONFIG[:app_id], app_namespace: 'main')
    p = hsign.params
    query = Rack::Utils::build_nested_query(p.merge(page: (params[:page] || '1')))
    uri = URI.parse("#{APP_CONFIG[:id_net_url]}/api/v1/json/activities?#{query}")
    http = Net::HTTP.new(uri.host, uri.port)
    result = JSON.parse(http.request(Net::HTTP::Get.new(uri.request_uri)).body)
    @page = result["page"]
    @pages_count = result["pages_count"]
    @activities = result["results"] || []
    @users = User.where(uid: @activities.map{|a| a['author_pid']}).index_by(&:uid)
  end

  def create
    result = JSON.parse(access_token.post('/api/v1/json/activities', {body: activity_params}).body)
    puts result
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
    params.merge!(url: 'http://localhost:9292/activities', app_id: APP_CONFIG[:app_id], request_ip: request.remote_ip, request_user_agent: request.env['HTTP_USER_AGENT'], request_referer: request.referer  )
  end
end
