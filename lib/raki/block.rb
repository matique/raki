# frozen_string_literal: true

# Middleware to execute a Block.
module Raki
  class Block < Raki::MiddlewareBase
    def call(env)
      my_env = env
      @block.call(my_env)
      @app.call(my_env)
    end
  end
end
