source 'https://rubygems.org'
gem 'rails', '3.2.18'

group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '~> 2.3.1'
  gem 'therubyracer'
end

group :development do
  gem 'sqlite3'
  gem 'capistrano', '3.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :production do
  gem 'mysql2'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

gem 'faraday', '~> 0.8.5'
gem 'faraday_middleware-parse_oj', '~> 0.2.1', require: 'faraday_middleware/parse_oj'
gem 'faraday_middleware'

gem 'hsign', require: 'hsign/digest'
gem 'jquery-rails'
gem "thin", ">= 1.5.0", :group => [:development, :test]
gem "unicorn", ">= 4.3.1", :group => :production
gem "omniauth-idnet" , github: 'idnet/omniauth-idnet'
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "hub", ">= 1.10.2", :require => nil, :group => [:development]
gem 'forgery'

