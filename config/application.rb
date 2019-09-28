
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SeoServiceSite
  class Application < Rails::Application
    config.load_defaults 5.2
    config.active_job.queue_adapter = :sidekiq
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: false
    end

    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'
  end
end
