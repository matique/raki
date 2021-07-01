# frozen_string_literal: true

require "test_helper"

class RR
  def initialize(*args, &block)
    @args = args
    @block = block
  end

  def call(env)
    hsh = env.dup
    deleted = []
    @args.each { |arg| deleted << hsh.delete(arg) }
    hsh = @block.call(env) if @block

    [200, hsh, deleted]
  end
end

describe Raki::Builder, "Parameter" do
  let(:env) { {a: 1, b: 2} }

  def test_filter_nothing
    app = Raki::Builder.app do
      add RR.new
    end

    assert_equal [200, {a: 1, b: 2}, []], app.call(env)
  end

  def test_filter_a
    app = Raki::Builder.app do
      add RR.new(:a)
    end

    assert_equal [200, {b: 2}, [env[:a]]], app.call(env)
  end

  def test_filter_with_block
    app = Raki::Builder.app do
      add(RR.new { |env| "123" })
    end

    assert_equal [200, "123", []], app.call(env)
  end
end
