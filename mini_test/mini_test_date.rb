# frozen_string_literal: true

require 'minitest/autorun'

# Date Unit Test
class MiniUnitDate < Minitest::Test
  def test_date
    assert_equal Time.new.strftime('%Y年%m月%d日　%H時%M分%S秒'), Time.now.strftime('%Y年%m月%d日　%H時%M分%S秒')
  end
end
