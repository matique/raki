require "test_helper"

describe Raki do
  let(:empty) { {body: []} }
  let(:hello) { {body: ["Hello World!"]} }
  let(:raki) { Raki::Raki.new }

  def test_zero
    assert Raki::ZERO
  end
end
