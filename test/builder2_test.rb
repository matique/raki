# frozen_string_literal: true

require 'test_helper'

describe Raki::Builder, 'Parallel' do
  def test_builder_collects_hash
    app = Raki::Builder.app do
      run lambda { |env| [200, {a: 111}, []] }
#      run lambda { |env| [200, {b: 2222}, []] }
#      run Raki::Nil.new
      run lambda { |env| [200, {}, []] }
    end

    expected = [200, {a: 111}, []]
    assert_equal expected, app.call(nil)
  end

  def test_builder_collects_body
    app = Raki::Builder.app do
      run lambda { |env| [200, {}, ['one']] }
      run lambda { |env| [200, {}, ['two']] }
    end

    status, hsh, body = app.call(nil)
    assert_equal 200, status
    assert_empty hsh
    assert body.include?('one')
    assert body.include?('two')
  end
end
