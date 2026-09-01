module Weirdy
  class Engine < ::Rails::Engine
    isolate_namespace Weirdy

    initializer "weirdy.assets.precompile" do |app|
      app.config.assets.precompile += %w( weirdy/application.js weirdy/application.css )
    end
  end
end
