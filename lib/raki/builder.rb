# frozen_string_literal: true

# see also
# cat ~/test/rack/lib/rack/builder.rb

# inspired by Rack::Builder
module Raki
  class Builder
    def initialize(default_app = nil, &block)
      @added = []
      @runs = [default_app].compact
      instance_eval(&block) if block_given?
    end

    # Create a new Raki::Builder instance and return the Raki application
    # generated from it.
    def self.app(default_app = nil, &block)
      new(default_app, &block).to_app
    end

    def add(middleware, *args, &block)
      raise 'No add allowed after a run' if @runs.size.positive?

      @added <<
        if middleware.instance_of?(Class)
          proc { |app| middleware.new(app, *args, &block) }
        else
          proc { |_app| middleware }
        end
    end
    ruby2_keywords(:add) if respond_to?(:ruby2_keywords, true)

    def run(app)
      @runs << app
    end

    def to_app
      app = fake_parallel(@runs)
      @added.reverse.inject(app) { |a, e| e[a] }
    end

   private
    def fake_parallel(runs)
      return runs.first if runs.size < 2

      app = lambda do |env|
        status, hsh, body = [200, {}, []]
        runs.shuffle.each { |run|
          s, h, b = run.call(env)
          status = s unless s == 200
          hsh.merge! h
          body << b unless b.empty?
        }

        [status, hsh, body.flatten]
      end
    end
  end
end
