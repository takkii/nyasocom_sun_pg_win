# frozen_string_literal: true

require 'grouse'
require 'minitest/autorun'
require 'time'

# rubygems/grouse
class KoyomiTest < Minitest::Test
  def test_koyomi
    @v1 = koyomi

    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    @v2 = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時" + "#{dt.min}分" + "#{dt.sec}秒" + ' : '.to_s + week + "曜日"

    # equal @v1 == @v2
    assert_equal(@v1, @v2)
  end
end