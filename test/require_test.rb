# frozen_string_literal: true

require 'test_helper'

describe Raki::Require do
  let(:env) { {a: 1, b: 2} }

  def test_require
    app = Raki::Builder.app do
      add(Raki::Require, :a, :b)
      run lambda { |env| [200, env, []] }
    end

   app.call(env)
  end

  def test_require_nothing
    app = Raki::Builder.app do
      add(Raki::Require)
      run lambda { |env| [200, env, []] }
    end

    err = assert_raises(Raki::RequireError) { app.call(env) }
    assert_equal 'Expected <>', err.message
  end
end
