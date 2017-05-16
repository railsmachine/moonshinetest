require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Moonshinetest
  class Application < Rails::Application
    
  # don't attempt to auto-require the moonshine manifests into the rails env
  config.paths.app.manifests 'app/manifests', :eager_load => false
  path_rejector = lambda { |s| s.include?("app/manifests") }
  config.eager_load_paths = config.eager_load_paths.reject(&path_rejector)
  # Remove the path from being lazily loaded
  ActiveSupport::Dependencies.autoload_paths.reject!(&path_rejector)


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
