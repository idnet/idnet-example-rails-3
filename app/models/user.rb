class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email

  def self.create_with_omniauth!(auth)
    user = User.new
    user.update_with_omniauth(auth)
  end

  def update_with_omniauth!(auth)
    info = auth['info']
    self.provider = auth['provider']
    self.uid = auth['uid']
    self.name = info['nickname']
    self.email = info['email']
    self.access_token = auth['credentials']['token'] if auth['credentials']['token']
    self.token_expires = auth['credentials']['expires_at'] if auth['credentials']['expires']
    self.refresh_token = auth['credentials']['refresh_token'] if auth['credentials']['refresh_token']
    self.save!
  end

end
