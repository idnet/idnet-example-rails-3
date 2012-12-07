module ApplicationHelper
  def id_net_url(path = nil)
    File.join(APP_CONFIG[:id_net_url], path)
  end
end
