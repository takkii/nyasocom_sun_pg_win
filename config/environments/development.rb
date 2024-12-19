require "active_support/core_ext/integer/time"

#Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # config.hosts << "tk2-410-46434.vs.sakura.ne.jp"
  # config.hosts << "blog.nyasocom.net"
  #config.reload_classes_only_on_change = false

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # config.action_mailer.delivery_method = :letter_opener_web
  # config.action_mailer.perform_deliveries = true

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  #config.cache_classes = false

  # Do not eager load code on boot.
  #config.eager_load = false

  # Show full error reports.
  #config.consider_all_requests_local = true

  # Enable server timing
  #config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  #if Rails.root.join("tmp/caching-dev.txt").exist?
  #  config.action_controller.perform_caching = true
  #  config.action_controller.enable_fragment_cache_logging = true

  #  config.cache_store = :memory_store
  #  config.public_file_server.headers = {
  #    "Cache-Control" => "public, max-age=#{2.days.to_i}"
  #  }
  #else
  #  config.action_controller.perform_caching = false

  #  config.cache_store = :null_store
  #end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  #config.active_storage.service = :local

  # Don't care if the mailer can't send.
  #config.action_mailer.raise_delivery_errors = false

  #config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  #config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  #config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  #config.active_support.disallowed_deprecation_warnings = []
  
  # DEPRECATION WARNING: `to_time` will always preserve the full timezone rather than offset of the receiver in Rails 8.1. 
  #config.active_support.to_time_preserves_timezone = :zone

  # Raise an error on page load if there are pending migrations.
  #config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  #config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  #config.assets.debug = true

  # Suppress logger output for asset requests.
  #config.assets.quiet = true

  # SCSS view moving changes.
  #config.assets.compile = true # 動的コンパイルを有効化
  # config.assets.css_compressor = :sass # sass-rails gemを使用している場合コメントアウトを外す
  #config.public_file_server.enabled = true # publicディレクトリ以下のアセットを返す設定

  #config.assets.precompile << %r{font-awesome/fonts/[\w-]+\.(?:eot|svg|ttf|woff2?)$}

  # ActionController::InvalidAuthenticityToken
  #config.action_controller.forgery_protection_origin_check = false

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  #config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  # config.file_watcher = ActiveSupport::FileUpdateChecker
#end

# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.active_record.maintain_test_schema = false

  # Turn false under Spring and add config.action_view.cache_template_loading = true.
  config.cache_classes = true

  # Eager loading loads your whole application. When running a single test locally,
  # this probably isn't necessary. It's a good idea to do in a continuous integration
  # system, or in some way before deploying your code.
  config.eager_load = ENV["CI"].present?

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory.
  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true
end
