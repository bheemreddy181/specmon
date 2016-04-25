require 'jquery-rails'
require 'bootstrap-sass'
require 'kaminari'
require 'bootstrap-kaminari-views'
require 'haml-rails'

module Specmon
  class Engine < ::Rails::Engine
    isolate_namespace Specmon
    initializer 'specmon' do |app|
      %w(stylesheets images javascripts).each do |sub|
        app.config.assets.paths << root.join('assets', sub).to_s
      end
      # use a proc instead of a string
      app.config.assets.precompile << proc { |path| path =~ /\Aspecmon\/application\.(js|css)\z/ }
      app.config.assets.precompile << proc { |path| path =~ /\Aspecmon\/.+\.(eot|svg|ttf|woff)\z/ }
      app.config.assets.precompile << %r{bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$}
      # other yaml options
      Specmon.time_zone ||= Specmon.settings['time_zone'] || Time.zone
    end
  end
end
