rails_env = ENV["RAILS_ENV"] || "development"

threads 4, 4

bind "unix:///home/bridge/apps/bridge/shared/sockets/bridge.sock"
