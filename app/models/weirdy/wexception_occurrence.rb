module Weirdy
  class WexceptionOccurrence < ActiveRecord::Base
    belongs_to :wexception, optional: true

    serialize :backtrace
    serialize :data
  end
end
