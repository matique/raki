require "test_helper"

class RR < Raki::Middleware
  def call(env)
    hsh = env.dup
    result = []
    @args.each { |arg| result << hsh.delete(arg) }
    result = @block.call(env) if @block
    return result unless @app

    result + @app.call(env)
  end
end

describe Raki::Builder, "Parameter" do
  let(:env) { {a: 1, b: 2} }

  def test_nil
    app = Raki::Builder.new do
      add RR
    end

    assert_equal [], app.call(env)
  end

  def test_a
    app = Raki::Builder.new do
      add RR, :a
    end

    assert_equal [env[:a]], app.call(env)
  end

  def test_a_b
    app = Raki::Builder.new do
      add RR, :a, :b
    end

    assert_equal [1, 2], app.call(env).sort
  end

  def test_chained
    app = Raki::Builder.new do
      add RR, :a
      add RR, :b
    end

    assert_equal [1, 2], app.call(env).sort
  end

  def test_with_block
    app = Raki::Builder.new do
      add(RR) { |env| "123" }
    end

    assert_equal "123", app.call(env)
  end
end
