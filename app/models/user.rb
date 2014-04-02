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
  
  
  def create_with_idnet_api(hash)
    self.provider = 'idnet'
    self.uid = hash['pid']
    self.name = hash['nickname']
    self.email = hash['email']
    self.access_token = hash['access_token'] if hash['access_token'].present?
    self.token_expires = hash['expires_in'].to_i.seconds.from_now if hash['expires_in'].present?
    self.refresh_token = hash['access_token'] if hash['access_token'].present?
    self.save!
  end

end
__END__

# Response data from idnet registration api
{
  "level"=>0,
  "trust_details"=>{
    "email"=>nil,
    "mobile"=>false, "certification"=>false
  },
  "nickname"=>"Hery",
  "email"=>"hery+4@id.net",
  "first_name"=>nil,
  "last_name"=>nil,
  "dob"=>nil,
  "language"=>nil,
  "gender"=>nil,
  "street_address"=>nil,
  "state_or_province"=>nil,
  "city"=>nil,
  "zip"=>nil,
  "country"=>nil,
  "pid"=>"533c0f8b1e540d170b000009",
  "avatars"=>
  {"thumb_url"=>nil,
    "thumb_secure_url"=>nil,
    "medium_url"=>nil,
    "medium_secure_url"=>nil,
    "large_url"=>nil,
    "large_secure_url"=>nil},
    "version"=>"522ef87ee50b532df25ca23ff48f7ca2",
    "risk"=>
    {"registration"=>{"risk"=>nil, "real_ip"=>nil, "request_ip"=>nil},
    "login"=>{"risk"=>nil, "iovation_ip"=>nil, "request_ip"=>nil}},
    "access_token"=>
    "8d29fe33f698861925a37edc779b394eb6b1ded8c7c1f22303e9c0ccf304598b",
    "refresh_token"=>
    "5435bf5d750aa347614e8e2f241c0314e4c560892267a6e270c1141c4464b6da",
    "token_type"=>"bearer",
    "expires_in"=>31536000,
    "scope"=>""}