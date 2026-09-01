require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "weirdy"

module Dummy
  class Application < Rails::Application
    # Mirrors the target host apps: nil default_column_serializer, so any bare
    # `serialize` in the engine must fail loudly (guard specs rely on this).
    config.load_defaults 7.1

    # Weirdy serializes captured request params (ActionController::Parameters)
    # into a YAML column; hosts need this same setting to read those rows back.
    # Under Psych >= 5.1 Rails 7.1 safe-dumps with these classes too, so the
    # transitive closure must be permitted: Parameters wraps an HWIA internally,
    # and context data may carry Symbol keys.
    config.active_record.yaml_column_permitted_classes = [ActionController::Parameters, ActiveSupport::HashWithIndifferentAccess, Symbol]
  end
end
