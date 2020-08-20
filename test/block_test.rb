# frozen_string_literal: true

require 'test_helper'

describe Raki::Block do
  let(:env) { {a: 1, b: 2} }

  def test_block
    n = 3
    app = Raki::Builder.app do
      add(Raki::Block) { |env| env[:c] = n }
      run lambda { |env| [200, env, []] }
    end

    assert_equal [200, {c: 3}, []], app.call({})
  end

  def test_no_block
    assert_raises() {
      Raki::Builder.app do
        add(Raki::Block)
      end.call({})
    }
  end
end
