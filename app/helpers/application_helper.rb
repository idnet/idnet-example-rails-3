module ApplicationHelper
  def id_net_url(path = nil)
    File.join(APP_CONFIG[:id_net_url], path)
  end

  def idnet_registrations_url
    id_net_url('registrations')
  end
end
