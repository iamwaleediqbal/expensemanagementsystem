require_relative "boot"

require "rails/all"
require 'stripe'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ExpenseManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Stripe.api_key = 'sk_test_51JRUZKA2D09SifibMCLtmVlrNKBxd8hTGLDlkf8jG0AilwF624lM3sqYroRwnVF80beLmZWDRPvynjTWnpUyUx6g00gmxuF7Uc'
    # Stripe::PaymentIntent.create({
    #   amount: 1000,
    #   currency: 'usd',
    #   payment_method_types: ['card'],
    #   receipt_email: 'jenny.rosen@example.com',
    # })
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
