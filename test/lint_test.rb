require "test_helper"

describe Raki::Lint do
  def test_built
    app = Raki::Builder.new do
      add Raki::Lint
      add Raki::Idem
    end

    assert_equal({}, app.call({}))
  end

  def test_nil_param
    app = Raki::Lint.new
    err = assert_raises(Raki::LintError) { app.call(nil) }
    assert_equal "No env given", err.message
  end
end
