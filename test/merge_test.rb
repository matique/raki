# frozen_string_literal: true

require "test_helper"

describe Raki::Merge do
  let(:hsh) { {a: 1, b: 2} }

  def test_merge_a
    app = Raki::Merge.new(a: 1) { |hsh| hsh }
    assert_equal({a: 1}, app.call({}))
  end

  def test_merge_a_b
    app = Raki::Merge.new(a: 1, b: 2) { |hsh| hsh }
    assert_equal({a: 1, b: 2}, app.call({}))
  end

  def test_merge_adding
    app = Raki::Merge.new(b: 2) { |hsh| hsh }
    assert_equal({a: 1, b: 2}, app.call(a: 1))
  end

  def test_merge_nothing
    app = Raki::Merge.new({}) { |hsh| hsh }
    assert_equal({a: 1, b: 2}, app.call(hsh))
  end

  def test_chained
    app = Raki::Builder.new do
      add Raki::Merge, a: 1
      add Raki::Merge, b: 2
      add Raki::Idem
    end

    assert_equal({a: 1, b: 2}, app.call(hsh))
  end

  def test_merge_with_block
    n = 3
    app = Raki::Merge.new({}) { |hsh|
      hsh[:c] = n
      hsh
    }
    assert_equal({c: 3}, app.call({}))
  end
end
