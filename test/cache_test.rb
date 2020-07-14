# frozen_string_literal: true

require 'helper'

# must be tested in a Rails environment
# Test is somehow faked

describe Raki::Cache do
  let(:empty) { [200, {}, []] }

  def test_cache
    app = Raki::Builder.app do
      add Raki::Cache
      run lambda { |env| [200, {}, []] }
    end

    result1 = app.call({})
    result2 = app.call({})
    assert_equal result1, result2
  end

end
