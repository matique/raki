# frozen_string_literal: true

require 'crimp'

# not yet finished
# requires a Rails environment! (see Rails below)
# middleware for caching.

module Raki
  class Cache < Raki::MiddlewareBase
    def call(env)
      @block&.call(env)
      kache(Crimp.signature(env)) {
        @app.call(env)
      }
    end

   private
    def kache(key, &block)
      # raise 'Missing Rails environment' unless defined?(Rails.cache)
      return yield unless defined?(Rails.cache)

      Rails.cache.fetch(key, expires_in: 1.hour, &block)
    end
  end
end
