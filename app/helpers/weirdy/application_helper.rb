module Weirdy
  module ApplicationHelper
    def weirdy_time_format(time, ago = false)
      time_str = time.strftime('%b %d, %Y - %H:%M:%S')
      time_str += " (#{time_ago_in_words time} ago)" if ago
      time_str
    end
  end
end
