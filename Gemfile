source 'https://rubygems.org'
gem 'rails', '3.2.8'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-debugger'
end

gem 'hsign', require: 'hsign/digest'
gem 'jquery-rails'
gem "thin", ">= 1.5.0", :group => [:development, :test]
gem "unicorn", ">= 4.3.1", :group => :production
gem "omniauth-idnet" , github: 'idnet/omniauth-idnet'
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "hub", ">= 1.10.2", :require => nil, :group => [:development]
gem 'forgery'

