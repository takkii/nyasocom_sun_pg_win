# frozen_string_literal: true

require 'minitest/autorun'

# Sort Unit Test
class MiniUnitSort < Minitest::Test
  def test_date
    array = ['Ruby', 'Java', 'Go', 'Hive', 'Perl', 'C#']
    @so = array.sort!
    @so2 = array.sort
    assert_equal @so, @so
  end
end
