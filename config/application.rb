require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'prometheus_exporter'
require 'prometheus_exporter/middleware'

module TasksApi
  class Application < Rails::Application
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
    config.middleware.insert_before 0, PrometheusExporter::Middleware
  end
end
