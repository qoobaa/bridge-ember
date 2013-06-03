rails_env = ENV["RAILS_ENV"] || "development"
threads 4, 16
bind "tcp://127.0.0.1:#{ENV['PORT']}"
