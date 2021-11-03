# frozen_string_literal: true

module Raki
  autoload :Builder, "raki/builder"
  autoload :Chain, "raki/chain"
  autoload :Idem, "raki/idem"
  autoload :Lint, "raki/lint"
  autoload :Merge, "raki/merge"
  autoload :Middleware, "raki/middleware"
  autoload :Params, "raki/params"
  autoload :Require, "raki/require"
  autoload :Slice, "raki/slice"

  ZERO = {body: []}

  class Base
    def initialize(*args)
      @args = args
    end

    def call(env)
      ZERO
    end
  end
end
