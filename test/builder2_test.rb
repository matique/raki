require "test_helper"

class MW < Raki::Middleware
  def call(env)
    result = env + @args.first
    return result unless @app

    @app.call(result)
  end
end

describe Raki::Builder do
  def setup
    @app_lm = Raki::Builder.new do
      add MW, "l"
      add MW, "m"
    end

    @app_ml = Raki::Builder.new do
      add MW, "m"
      add MW, "l"
    end
  end

  def test_simple1
    app_lm = @app_lm # @app_lm not accessible in closure
    app = Raki::Builder.new do
      add app_lm
    end

    assert_equal "lm", app.call("")
  end

  def test_simple2
    app_ml = @app_ml
    app = Raki::Builder.new do
      add app_ml
    end

    assert_equal "ml", app.call("")
  end

  def test_readme
    app = Raki::Builder.new do
      add MW, "a"
      add MW, "b"
    end

    assert_equal "ab", app.call("")
  end

  def test_nested_build_chain
    app_ml = @app_ml
    app_lm = @app_lm
    app2 = Raki::Chain.new do
      add app_lm
      add app_ml
    end
    assert_equal "lmml", app2.call("")

    app = Raki::Chain.new do
      add app2
      add app2
    end

    assert_equal "lmmllmml", app.call("")
  end
end
