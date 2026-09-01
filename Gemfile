source "https://rubygems.org"

# Declare your gem's dependencies in weirdy.gemspec.
gemspec

# Development/test stack for the engine dummy app.
gem "rails", "~> 7.1.6"

gem "pg"
gem "kaminari"
gem "jquery-rails"          # app/assets/javascripts/weirdy/application.js requires jquery + jquery_ujs
gem "sprockets-rails"       # rails/all no longer implies an asset pipeline
gem "delayed_job"           # used by test/dummy/app/jobs/notifier_job.rb
gem "delayed_job_active_record"

group :test do
  gem "rails-controller-testing"   # restores assigns() used by controller tests (dev/test only)
end
