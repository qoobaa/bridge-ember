require "bundler/capistrano"

set :application, "bridge"
set :deploy_to, "/home/bridge/apps/#{application}"
set :user, "bridge"
set :repository,  "git://github.com/qoobaa/bridge-ember.git"
set :use_sudo, false
# set :default_environment, "PATH" => "~/.nvm/v0.11.2/bin:~/.rbenv/shims:~/.rbenv/bin:$PATH"
set :rails_env, "production"
set :keep_releases, 3

server "bridge-arch.jah.pl:43377", :web, :app, :db, primary: true

before "bundle:install", "deploy:symlink_db", "deploy:symlink_env"
after "deploy:update_code", "deploy:socket_npm_install"
after "deploy:update", "foreman:export", "foreman:restart", "deploy:cleanup"

namespace :deploy do
  task :symlink_db, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :symlink_env, roles: :app do
    run "ln -nfs #{shared_path}/config/.env.production #{release_path}/.env.production"
  end

  desc "Install node modules for socket"
  task :socket_npm_install do
    run "cd #{release_path}/socket && npm install"
  end
end

namespace :foreman do
  desc "Export the Procfile to systemd scripts"
  task :export, roles: :app do
      # sudo env PATH=$PATH bundle exec foreman export systemd /etc/systemd/system -f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log -e .env.production
    run <<-CMD.compact
      cd #{current_path} &&
      sudo bundle exec foreman export systemd /etc/systemd/system -f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log -e .env.production
    CMD
  end

  desc "Start the application services"
  task :start, roles: :app do
    sudo "systemctl start #{application}"
  end

  desc "Stop the application services"
  task :stop, roles: :app do
    sudo "systemctl stop #{application}"
  end

  desc "Restart the application services"
  task :restart, roles: :app do
    run "sudo systemctl start #{application} || sudo systemctl restart #{application}"
  end
end
