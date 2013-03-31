require "bundler/capistrano"

set :application, "bridge"
set :deploy_to, "/home/bridge/apps/#{application}"
set :user, "bridge"
set :repository,  "git://github.com/qoobaa/bridge-ember.git"
set :use_sudo, false
set :default_environment, "PATH" => "/home/bridge/.nvm/v0.10.2/bin:/home/bridge/.rbenv/shims:/home/bridge/.rbenv/bin:$PATH"

set :shared_children, shared_children + %w[config/database.yml]

server "bridge.jah.pl:43377", :web, :app, :db, primary: true
