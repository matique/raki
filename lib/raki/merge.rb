# frozen_string_literal: true

# Middleware Merge.
module Raki
  class Merge < Raki::MiddlewareBase
    def call(env)
      my_env = env.merge(*@args)
      @block&.call(my_env)
      @app.call(my_env)
    end
  end
end
