# frozen_string_literal: true

require 'helper'

describe Raki::Nil do
  let(:raki) { Raki::Nil.new }
  let(:empty) { [200, {}, []] }
  let(:ping) { [200, {}, ['ping']] }

  def test_class
    assert_instance_of Raki::Nil, raki
  end

  def test_nil
    proc = lambda { |env| [200, {}, []] }
    assert_equal empty, proc.call({})

    assert_equal empty, Raki::Nil.new.call({})
  end

  def test_ping
    proc = lambda { |env| [200, {}, ['ping']] }
    assert_equal ping, proc.call({})
  end
end
