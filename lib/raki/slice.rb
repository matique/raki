# frozen_string_literal: true

# Middleware Slice.
module Raki
  class Slice < Raki::MiddlewareBase
    def call(env)
      my_env = env.slice(*@args.flatten)
      @block&.call(my_env)
      @app.call(my_env)
    end
  end
end
