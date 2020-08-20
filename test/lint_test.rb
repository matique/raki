# frozen_string_literal: true

require 'test_helper'

describe Raki::Lint do
  let(:empty) { [200, {}, []] }

  def test_no_env
    app = Raki::Builder.app do
      add Raki::Lint
      run Raki::Nil.new
    end

    assert_equal empty, app.call({})
    err = assert_raises(Raki::LintError) { app.call(nil) }
    assert_equal 'No env given', err.message
  end

  def test_lint_result
    app = app_build [200, {}, []]
    assert_equal empty, app.call({})
  end

  def test_lint_with_block
    app = Raki::Builder.app do
      add(Raki::Lint) { |env| false }
      run Raki::Nil.new
    end

    check_assert app, 'Block complained'
  end

  def test_assert_response_array
    app = app_build({})
    check_assert app, 'Expected array'
  end

  def test_assert_response_three_items
    app = app_build []
    check_assert app, 'Expected array of 3 items'
  end

  def test_assert_response_first
    app = app_build [:wrong, 2, 3]
    check_assert app, 'First item must be an Integer'
  end

  def test_assert_response_second
    app = app_build [1, 2, 3]
    check_assert app, 'Second item must be a Hash'
  end

  def test_assert_response_third
    app = app_build [1, {}, 3]
    check_assert app, 'Third item must be an Array'
  end

 private
  def app_build(result)
    Raki::Builder.app do
      add Raki::Lint
      run lambda { |env| result }
    end
  end

  def check_assert(app, msg)
    err = assert_raises(Raki::LintError) { app.call({}) }
    assert_equal msg, err.message
  end

end
