# frozen_string_literal: true

require 'minitest/autorun'

# UpDown Unit Test
class MiniUnitUpDown < Minitest::Test
  def test_updown
    str = 'object oriented language'
    str2 = 'RUBY_VERSION_IS'
    @upup = str.upcase
    @upup2 = 'object oriented language'.upcase
    @downdown = str2.downcase
    @downdown2 = 'RUBY_VERSION_IS'.downcase
    assert_equal @upup, @upup2
    assert_equal @downdown, @downdown2
  end
end
