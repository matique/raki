require "test_helper"

describe Raki::Middleware do
  def test_simple
    app = Raki::Middleware.new
    assert_equal Raki::ZERO, app.call("")

    app = Raki::Middleware.new("aa")
    assert_equal Raki::ZERO, app.call("")

    app = Raki::Middleware.new {}
    assert_nil app.call("")
  end
end
