require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nyasocom3
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.fallbacks = true
    config.i18n.fallbacks = [I18n.default_locale]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    Rails.application.config.assets.unknown_asset_fallback = true
    config.assets.paths << Rails.root.join('node_modules')
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Tokyo'
    config.generators.javascript_engine = :js
    config.active_record.default_timezone = :local

    # factory_bot
    # config.factory_bot.definition_file_paths = ["spec/factories"]

    # warning
    # ActiveSupport::Deprecation.silenced = true if Rails.version == '8.0.1'

    # rspec
    config.generators do |g|
      g.test_framework = "rspec"
      g.controller_specs = false
      g.helper_specs = false
      g.view_specs = false
    end
  end
end
