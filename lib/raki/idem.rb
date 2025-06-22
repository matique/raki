# frozen_string_literal: true

# Returns "env" (doing nothing)
module Raki
  class Idem < Raki::Middleware
    def call(env)
      env
    end
  end
end
