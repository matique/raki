# frozen_string_literal: true

# Middleware just passing over or returning the params.
module Raki
  class MiddlewareBase
    def initialize(app = nil, *args, &block)
      @app = app
      @args = args
      @block = block
    end

    def call(_env)
      raise '#call must be overwritten by a middleware raki'
    end
  end
end
