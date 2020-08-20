# frozen_string_literal: true

require 'test_helper'

class MB < Raki::MiddlewareBase
end

describe Raki::MiddlewareBase do
  let(:rr) { MB.new }

  def test_class
    assert_instance_of MB, rr
    assert_kind_of Raki::MiddlewareBase, rr
  end

  def test_call
    err = assert_raises() { rr.call({}) }
    assert_equal '#call must be overwritten by a middleware raki', err.message
  end
end
