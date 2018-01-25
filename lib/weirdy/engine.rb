module Weirdy
  class Engine < ::Rails::Engine
    isolate_namespace Weirdy

    initializer "weirdy.assets.precompile" do |app|
      app.config.assets.precompile += %w( application.js application.css )
    end
  end
end
