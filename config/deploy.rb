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

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run <<-CMD.compact
      cd #{release_path} &&
      sudo $(rbenv which bundle) exec foreman export upstart /etc/init -f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log -e .env.production
    CMD
  end

  desc "Start the application services"
  task :start, :roles => :app do
    sudo "start #{application}"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    sudo "stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "sudo start #{application} || sudo restart #{application}"
  end
end
