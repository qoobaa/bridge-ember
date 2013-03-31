require "bundler/capistrano"

set :application, "bridge"
set :deploy_to, "/home/bridge/apps/#{application}"
set :user, "bridge"
set :repository,  "git://github.com/qoobaa/bridge-ember.git"
set :use_sudo, false
set :default_environment, "PATH" => "/home/bridge/.nvm/v0.10.2/bin:/home/bridge/.rbenv/shims:/home/bridge/.rbenv/bin:$PATH"
set :rails_env, "production"

server "bridge.jah.pl:43377", :web, :app, :db, primary: true

before "bundle:install", "deploy:symlink_db"
before "bundle:install", "deploy:symlink_env"

namespace :deploy do
  task :symlink_db, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :symlink_env, roles: :app do
    run "ln -nfs #{shared_path}/config/.env.production #{release_path}/.env.production"
  end

  # https://github.com/capistrano/capistrano/issues/362
  namespace :assets do
    task :precompile, roles: assets_role, except: {no_release: true} do
      run <<-CMD.compact
        cd -- #{latest_release.shellescape} &&
        #{rake} RAILS_ENV=#{rails_env.to_s.shellescape} #{asset_env} assets:precompile
      CMD
    end
  end
end
