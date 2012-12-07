IdnetRails::Application.config.middleware.use OmniAuth::Builder do
  provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
    fields: OmniAuth::Idnet::DEFAULT + ['dob'],
    client_options: {
      site: APP_CONFIG[:id_net_url],
      authorize_url: "#{APP_CONFIG[:id_net_url]}/oauth/authorize",
      access_token_url: "#{APP_CONFIG[:id_net_url]}/oauth/token"
      }
end
