# frozen_string_literal: true

# validates according to Raki definition.
module Raki
  class LintError < RuntimeError; end

  class Lint < Raki::Middleware
    def call(env)
      assert("No env given") { env }
      # assert("Run complained") { @block.call(env) } if @block

      result = @app&.call(env)
      assert("Expected hash") { result.instance_of?(Hash) }
      result
    end

    private

    def assert(message)
      return if yield

      raise LintError, message
    end
  end
end
