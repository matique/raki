# frozen_string_literal: true

# Middleware Slice.
module Raki
  class Slice < Raki::Middleware
    def call(env)
      my_env = env.slice(*@args.flatten)
      app = @block || @app
      app.call(my_env)
    end
  end
end
