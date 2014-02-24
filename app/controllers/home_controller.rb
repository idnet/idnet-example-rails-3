require "net/http"

class HomeController < ApplicationController
  wrap_parameters format: []

  def trace_event
    puts ''
    puts '###############################################'
    hsign = HSign::Digest.new(APP_CONFIG[:app_secret], APP_CONFIG[:app_id])
    request.request_parameters.each do |key, value|
      puts ":#{key} => #{value}"
    end
    puts "Hmac verified?: #{hsign.verify? request.request_parameters}"
    puts '###############################################'
    puts ''
    render json: {}, status: :ok
  end
end
