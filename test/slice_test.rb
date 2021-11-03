# frozen_string_literal: true

require "test_helper"

describe Raki::Slice do
  let(:hsh) { {a: 1, b: 2} }
  let(:through) { ->(hsh) { hsh } }

  def test_a
    check :a, {a: 1}
  end

  def test_a2
    app = Raki::Slice.new(:a) { |hsh| hsh }
    assert_equal({a: 1}, app.call(hsh))
  end

  def test_a_b
    app = Raki::Slice.new(:a, :b, &through)
    assert_equal({a: 1, b: 2}, app.call(hsh))
  end

  def test_array
    check [:a, :b], {a: 1, b: 2}
  end

  def test_none
    check nil, {}
  end

  def test_chained
    app = Raki::Builder.new do
      add Raki::Slice, :a, :b
      add Raki::Slice, :b, :c
      add Raki::Idem
    end

    assert_equal({b: 2}, app.call(hsh))
  end

  def test_indented
    app2 = Raki::Slice.new(:b, :c) { |hsh| hsh }
    app = Raki::Slice.new(:a, :b) { |hsh| app2.call(hsh) }

    assert_equal({b: 2}, app.call(hsh))
  end

  private

  def check(param, expected)
    app = Raki::Slice.new(param, &through)
    assert_equal(expected, app.call(hsh))
  end
end
