# frozen_string_literal: true

# Middleware Require.
module Raki
  class RequireError < RuntimeError; end

  class Require < Raki::MiddlewareBase
    def call(env)
      expected = @args.flatten.sort
      bool = env.keys.sort == expected
      raise(RequireError, "Expected <#{expected.join}>") unless bool

      @block&.call(env)
      @app.call(env)
    end
  end
end
