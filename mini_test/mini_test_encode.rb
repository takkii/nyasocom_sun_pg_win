# frozen_string_literal: true

require 'minitest/autorun'

# Encode Unit Test
class MiniUnitEncode < Minitest::Test
  def test_encode
    @str = '日本語文字列を確認'
    assert_equal @str, @utf8_str = @str.encode('UTF-8')
  end
end
