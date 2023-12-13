# frozen_string_literal: true

module Raki
  class Builder < Raki::Base
    # attr_accessor :stack

    def initialize(&block)
      @stack = []
      instance_eval(&block) if block
      chain
    end

    def add(middleware, ...)
      @stack <<
        if middleware.instance_of?(Class)
          middleware.new(...)
        else
          middleware
        end
    end

    def chain
      previous = nil
      @stack.each do |app|
        previous.app = app if previous
        previous = app
      end
    end

    def call(hsh = {})
      @stack.first&.call(hsh)
    end

    # def to_s(pre = "")
    #   next_pre = pre + "  "
    #   res = []
    #   res << "#{pre}#{self.class.name} #{object_id}"
    #   res << "#{pre}@stack.length #{@stack.length}"
    #   @stack.each_with_index { |mv, idx|
    #     res << "#{pre}[#{idx}] #{mv.to_s(next_pre)}"
    #   }
    #   res.flatten.join("\n")
    # end
  end
end
