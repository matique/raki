require "test_helper"

class ZZ < Raki::Base

end

describe Raki do
  let(:base) { Raki::Base.new }

  def test_zero
    assert Raki::ZERO
  end

  def test_coverage
    assert Raki::ZERO, base.call("")
  end
end
