Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local
  config.action_mailer.default_url_options = { host: 'localhost:3000'  }
#   # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025
 }
  config.action_mailer.raise_delivery_errors = false

# config.action_mailer.delivery_method = :smtp
# config.action_mailer.default_url_options = { :host => ENV['MAIL_HOST'] }
# ActionMailer::Base.smtp_settings = {
#     :address        => "smtp.gmail.com",
#     :port           => '587',
#     :authentication => :plain,
#     :user_name      => ENV['GMAIL_USERNAME'],
#     :password       => ENV['GMAIL_PASSWORD'],
#     :openssl_verify_mode  => 'none'
# }
# config.action_mailer.raise_delivery_errors = true
  # *************** MAILER ******************
  #  1. Use the following settings:
  #
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default :charset => "utf-8"
  # config.action_mailer.smtp_settings = {
  #   :address => "smtp.gmail.com",
  #   :port => 587,
  #   :domain => 'smtp.gmail.com',
  #   :user_name => "username@gmail.com",
  #   :password => "yourpassword",
  #   :authentication => :login,
  #   :enable_starttls_auto => true
  # }
  # 2. Make sure you have "Access for less secure apps" turned ON at https://www.google.com/settings/security/lesssecureapps
  #
  # 3. Go to https://g.co/allowaccess from another device you have previously used to access your google account.

  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default_url_options = { host: ENV['MAIL_HOST'] }
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #     user_name:      ENV['SENDMAIL_USERNAME'],
  #     password:       ENV['SENDMAIL_PASSWORD'],
  #     domain:         ENV['MAIL_HOST'],
  #     address:       'smtp.gmail.com',
  #     port:          '587',
  #     authentication: :plain,
  #     enable_starttls_auto: true
  # }


  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
