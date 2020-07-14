# frozen_string_literal: true

require 'helper'

describe Raki::Merge do
  let(:env) { {a: 1, b: 2} }

  def test_merge_a
    app = Raki::Builder.app do
      add Raki::Merge, a: 1
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {:a=>1}, []], app.call({})
  end

  def test_merge_a_b
    app = Raki::Builder.app do
      add Raki::Merge, a: 1, b: 2
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {:a=>1, b: 2}, []], app.call({})
  end

  def test_merge_adding
    app = Raki::Builder.app do
      add Raki::Merge, b: 2
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {:a=>1, b: 2}, []], app.call(a: 1)
  end

  def test_merge_nothing
    app = Raki::Builder.app do
      add Raki::Merge
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {a: 1, b: 2}, []], app.call(env)
  end

  def test_merge_twice
    app = Raki::Builder.app do
      add Raki::Merge, a: 1
      add Raki::Merge, b: 2
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {a: 1, b: 2}, []], app.call({})
  end

  def test_merge_with_block
    n = 3
    app = Raki::Builder.app do
      add(Raki::Merge) { |env| env[:c] = n }
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {c: 3}, []], app.call({})
  end
end
