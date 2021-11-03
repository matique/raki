# frozen_string_literal: true

# Rreturns "env" (doing nothing)
module Raki
  class Idem < Raki::Middleware
    def call(env)
      env
    end
  end
end
