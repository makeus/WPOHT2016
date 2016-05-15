source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'sass-rails', '~> 5.0'
gem "autoprefixer-rails"
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks'
gem 'nprogress-rails'
gem 'jbuilder', '~> 2.0'
gem 'httparty'
gem 'react-rails'
gem 'jquery-rails'
gem 'sprockets-rails', :require => 'sprockets/railtie'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :development, :test do
  gem 'byebug'
  gem "better_errors"
  gem 'rspec-rails', '~> 3.0'
end


group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'webmock'
end
