require "test_helper"

describe Raki::Idem do
  def test_a
    app = Raki::Idem.new
    assert_equal "a", app.call("a")
  end

  def test_hsh
    hsh = {}
    app = Raki::Idem.new
    assert_equal hsh, app.call(hsh)
  end
end
