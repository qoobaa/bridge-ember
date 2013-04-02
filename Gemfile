source "https://rubygems.org"

ruby "2.0.0"

gem "rails", "4.0.0.beta1"

gem "jbuilder"
gem "ember-rails", github: "emberjs/ember-rails"
gem "foreman"
gem "redis"
gem "pg"
gem "puma"
gem "bridge", github: "qoobaa/bridge"

group :assets do
  gem "sass-rails",   "~> 4.0.0.beta1"
  gem "coffee-rails", "~> 4.0.0.beta1"
  gem "uglifier", ">= 1.0.3"
end

group :development, :test do
  gem "debugger"
  gem "konacha", ">= 2.5.1"
  gem "poltergeist"
  gem "capistrano"
end

group :test do
  gem "factory_girl_rails"
end
