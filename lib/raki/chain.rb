# frozen_string_literal: true

module Raki
  class Chain < Base
    def initialize(*args, &block)
      super
      @stack = []
      instance_eval(&block) if block
    end

    def add(middleware = nil, *args, &block)
      middleware ||= block
      @stack <<
        if middleware.instance_of?(Class)
          middleware.new(*args, &block)
        else
          middleware
        end
    end

    def call(hsh)
      my_hsh = hsh
      @stack.each { |app| my_hsh = app.call(my_hsh) }
      my_hsh
    end

    # def to_s(pre = "")
    #   next_pre = pre + "  "
    #   res = []
    #   res << "#{pre}#{self.class.name} #{object_id}"
    #   res << "#{pre}args #{@args}"
    #   #  res << @app.to_s(next_pre) if @app
    #   res << "#{pre}@app #{@app.object_id}" if @app
    #   @stack.each_with_index { |mv, idx|
    #     res << "#{pre}[#{idx}] #{mv.to_s(next_pre)}"
    #   }
    #   res.flatten.join("\n")
    # end
  end
end
