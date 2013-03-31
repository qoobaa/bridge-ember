require "bundler/capistrano"

set :application, "bridge"
set :user, "bridge"
set :repository,  "git://github.com/qoobaa/bridge-ember.git"
set :use_sudo, false

server "bridge.jah.pl", :web, :app, :db, primary: true
