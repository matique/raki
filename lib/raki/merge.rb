# frozen_string_literal: true

# Middleware Merge.
module Raki
  class Merge < Raki::Middleware
    def call(env)
      my_env = env.merge(*@args)
      app = @block || @app
      app.call(my_env)
    end
  end
end
