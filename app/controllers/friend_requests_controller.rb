require 'net/http'

class FriendRequestsController < ApplicationController
  def index
    @idnet_people = User.all
  end
end
