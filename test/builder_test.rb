# frozen_string_literal: true

require 'test_helper'

describe Raki::Builder do
  let(:raki_nil) { Raki::Nil.new }
  let(:empty) { [200, {}, []] }

  def test_builder_empty
    app = Raki::Builder.new

    assert_kind_of Raki::Builder, app
    assert_raises() { app.call({}) }
  end

  def test_builder_lambda
    app = Raki::Builder.app do
      run lambda { |env| [200, {}, ['OK']] }
    end

    expected = [200, {}, ['OK']]
    assert_equal expected, app.call(nil)
  end

  def test_builder_nil
    app = Raki::Builder.app do
      run Raki::Nil.new
    end

    assert_equal empty, app.call(nil)
  end

  def test_builder_idem
    app = Raki::Builder.app do
      run Raki::Idem.new
    end

    assert_empty app.call({})
    assert_equal empty, app.call(empty)
  end

  def test_builder_idem2
    app = Raki::Builder.app do
      add Raki::Idem
      run lambda { |env| env }
    end

    assert_empty app.call({})
    assert_equal empty, app.call(empty)
  end
end

# see also
# cat ~/test/rack/test/spec_builder.rb
