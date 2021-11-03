require "test_helper"

class MM < Raki::Middleware
  def call(hsh)
    hsh + "C"
  end
end

describe Raki::Builder do
  def test_empty
    app = Raki::Builder.new

    assert_kind_of Raki::Builder, app
    assert_respond_to app, :call
    assert_nil app.call
  end

  def test_simple
    app = Raki::Builder.new
    assert_nil app.call

    app = Raki::Builder.new {}
    assert_nil app.call

    proc = ->(hsh) { hsh + "a" }
    app = Raki::Builder.new do
      add proc
    end
    assert_equal "a", app.call("")

    app = Raki::Builder.new do
      add MM
    end
    assert_equal "C", app.call("")
  end

  def test_one_lambda
    app = Raki::Builder.new do
      add(->(hsh) { {body: [hsh[:name]]} })
    end

    expected = {body: ["Name"]}
    assert_equal expected, app.call(name: "Name")
  end

  def test_built_stackable
    app2 = Raki::Builder.new do
      add(->(hsh) { hsh + "c" })
    end

    app = Raki::Chain.new do
      add app2
      add(->(hsh) { hsh + "b" })
    end

    expected = "acb"
    assert_equal expected, app.call("a")
  end
end
