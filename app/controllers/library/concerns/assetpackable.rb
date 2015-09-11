module Library
  module Assetpackable
    extend ActiveSupport::Concern

    included do
      assets do
        serve "/js", from: "app/assets/javascripts"
        serve "/vendor", from: "vendor/assets/javascripts"

        js :application, %w(/vendor/require.js /js/**/*.js)
        js_compression :jsmin
      end
    end
  end
end
