class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:private_data]
  def index
  end
  
  def private_data
    json = access_token.get('/api/profile')
    render text: json.as_json, layout: true
  end
end
