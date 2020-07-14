# frozen_string_literal: true

# Middleware just passing over or returning the params.
module Raki
  class Idem < Raki::MiddlewareBase
    def call(env)
      return env unless @app

      @block&.call(env)
      @app.call(env)
    end
  end
end
