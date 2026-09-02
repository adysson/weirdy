Dummy::Application.configure do
  config.cache_classes = true
  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Rails 7.1 deprecates booleans here; :none is the 8.0-correct value.
  config.action_dispatch.show_exceptions = :none

  config.action_controller.allow_forgery_protection = false

  config.action_mailer.delivery_method = :test

  config.active_support.deprecation = :stderr
end
