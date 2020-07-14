# frozen_string_literal: true

# Raki::AssertRequest validates your requests according to Raki spec.

# see also:
# cat ~/test/rack/lib/rack/lint.rb
# cat ~/test/rack/SPEC.rdoc
module Raki
  class LintError < RuntimeError; end

  class Lint < Raki::MiddlewareBase
    def call(env)
      assert('No env given') { env }
      assert('Block complained') { @block.call(env) } if @block

      @block&.call(env)
      response = @app.call(env)

      assert('Expected array') { response.class == Array }
      assert('Expected array of 3 items') { response.size == 3 }
      assert('First item must be an Integer') { response[0].class == Integer }
      assert('Second item must be a Hash') { response[1].class == Hash }
      assert('Third item must be an Array') { response[2].class == Array }

      response
    end

   private
    def assert(message)
      return if yield

      raise LintError, message
    end
  end
end
