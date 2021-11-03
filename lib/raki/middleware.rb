# frozen_string_literal: true

# Base for middleware
module Raki
  class Middleware
    attr_accessor :app

    def initialize(*args, &block)
      @app = nil
      @args = args
      @block = block
    end

    def call(env)
      my_env = env
      result = ZERO
      app = @block || @app
      return result unless app

      app.call(my_env)
    end

    # def to_s(pre = "")
    #   # next_pre = pre + "  "
    #   res = []
    #   res << "#{pre}#{self.class.name} #{object_id}"
    #   res << "#{pre}args #{@args}"
    #   # res << @app.to_s(next_pre) if @app
    #   res << "#{pre}@app #{@app.object_id}" if @app
    #   res.flatten.join("\n")
    # end
  end
end
