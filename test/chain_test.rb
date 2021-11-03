require "test_helper"

class CC < Raki::Base
  def call(hsh)
    hsh + @args.first
  end
end

describe Raki::Chain do
  def test_simple
    app = Raki::Chain.new
    assert_equal "", app.call("")

    app = Raki::Chain.new("aa")
    assert_equal "", app.call("")

    app = Raki::Chain.new {}
    assert_equal "", app.call("")

    proc = ->(hsh) { hsh + "a" }
    app = Raki::Chain.new do
      add proc
    end
    assert_equal "a", app.call("")

    app = Raki::Chain.new do
      add CC, "C"
    end
    assert_equal "C", app.call("")
  end

  def test_param
    app = Raki::Chain.new do
      add(->(hsh) { {body: ["lambda #{hsh[:name]}"]} })
    end

    expected = {body: ["lambda lambda"]}
    assert_equal expected, app.call(name: "lambda")
  end

  def test_readme
    proca = ->(hsh) { hsh + "a" }
    app = Raki::Chain.new do
      add CC, "C"
      add proca
      add { |hsh| hsh + "b" }
      add ->(hsh) { hsh + "c" }
    end
    assert_equal "Cabc", app.call("")
  end

  def test_double_chain
    proca = ->(hsh) { hsh + "a" }
    procb = ->(hsh) { hsh + "b" }
    app2 = Raki::Chain.new do
      add proca
      add procb
    end
    app = Raki::Chain.new do
      add app2
      add app2
    end
    assert_equal "abab", app.call("")
  end

  def test_blocks
    n = 123
    app = Raki::Chain.new do
      add { n }
      add { |env| env + 1 }
    end

    assert_equal n + 1, app.call({})
  end
end
