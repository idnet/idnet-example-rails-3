class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email

  def self.create_with_omniauth(auth)
    create! do |user|
      info = auth['info']
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = info['nickname']
      user.email = info['email']
      user.access_token = auth['credentials']['token']
      user.token_expires = auth['credentials']['expires']
    end
  end

end
