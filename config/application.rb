require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ProjectQa
  class Application < Rails::Application
    config.load_defaults 5.2


    config.action_cable.disable_request_forgery_protection = false

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false
    end

  end
end
