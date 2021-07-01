# frozen_string_literal: true

require "test_helper"

describe Raki::Slice do
  let(:env) { {a: 1, b: 2} }

  def test_slice_a
    app = Raki::Builder.app do
      add Raki::Slice, :a
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {a: 1}, []], app.call(env)
  end

  def test_slice_a_b
    app = Raki::Builder.app do
      add Raki::Slice, :a, :b
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {a: 1, b: 2}, []], app.call(env)
  end

  def test_slice_array
    app = Raki::Builder.app do
      add Raki::Slice, [:a, :b]
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {a: 1, b: 2}, []], app.call(env)
  end

  def test_slice_nothing
    app = Raki::Builder.app do
      add Raki::Slice
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {}, []], app.call(env)
  end

  def test_slice_twice
    app = Raki::Builder.app do
      add Raki::Slice, :a, :b
      add Raki::Slice, :b, :c
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {b: 2}, []], app.call(env)
  end
end
