# frozen_string_literal: true

require "test_helper"

describe Raki::Require do
  let(:hsh) { {a: 1, b: 2} }

  def test_run
    app = Raki::Require.new(:a, :b) { |hsh| hsh }
    app.call(hsh)
  end

  def test_no_param
    app = Raki::Require.new { |hsh| hsh }
    err = assert_raises(Raki::RequireError) { app.call(hsh) }
    assert_equal "Expected <>", err.message
  end
end
