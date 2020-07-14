# frozen_string_literal: true

# Returns a Raki zero.
module Raki
  class Nil < Raki::MiddlewareBase
    def call(_env)
      @block&.call(env)
      @app&.call(env)

      [200, {}, []]
    end
  end
end
