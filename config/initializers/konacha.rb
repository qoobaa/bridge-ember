if defined?(Konacha)
  # Fake option for konacha
  # https://github.com/jfirebaugh/konacha/issues/120
  Rails.application.config.assets.enabled = true

  require "capybara/poltergeist"

  Konacha.configure do |config|
    config.spec_dir = "test/javascripts"
    config.driver   = :poltergeist
  end
end
