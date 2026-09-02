module Weirdy
  class WexceptionOccurrence < ActiveRecord::Base
    belongs_to :wexception, optional: true

    # Explicit coder: under load_defaults 7.0+ the default column serializer is
    # nil, where bare `serialize` raises ArgumentError. YAML keeps byte-compat
    # with rows written by Rails <= 7.0 defaults (no data migration needed).
    serialize :backtrace, coder: YAML
    serialize :data, coder: YAML
  end
end
