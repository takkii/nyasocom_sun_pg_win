require 'minitest/autorun'

# raise throws Test_errs Class.
class Test_errs
  def self.raises(*exp)
    errs = 'raises'
    raise errs
  end
end

# Raises Test Classes.
class RaisesTest < Minitest::Test

  # raise throw check.
  def test_raises
    e = assert_raises RuntimeError do
      Test_errs.raises
    end

    # String == e.message
    assert_equal 'raises', e.message
  end
end