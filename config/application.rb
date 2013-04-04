require File.expand_path("../boot", __FILE__)

require "rails/all"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Bridge
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "images")
    config.assets.paths << Rails.root.join("app", "assets", "flash")
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
