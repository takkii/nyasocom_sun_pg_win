# frozen_string_literal: true

require 'minitest/autorun'

# Method Unit Test
class MiniUnitMethod < Minitest::Test
  def test_method
    # method test add.
    ary = []
    ary2 = %w[]

    1.step(10, 3) do |i|
      ary << i
      ary2 << i
    end

    assert_equal @step = ary, @step2 = ary2
  end
end
