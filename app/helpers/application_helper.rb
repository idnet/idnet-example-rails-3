module ApplicationHelper
  def id_net_url(path = nil)
    File.join(APP_CONFIG[:id_net_url], path)
  end
  
  def oauth_path(options = {})
    '/auth/idnet?' + Rack::Utils.build_nested_query(options)
  end

  def idnet_registrations_url
    id_net_url('register')
  end
end
