# frozen_string_literal: true

require 'time'
require 'core'
require 'minitest/autorun'

# Mini_test file load.
class HimekuriTest < Minitest::Test
  def test_himekuri
    # dotenv == string
    @koyomi = CoreNYM.koyomi

    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    @himekuri = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時"+"#{dt.min}分"+"#{dt.sec}秒" + ' : '.to_s + week + "曜日"

    assert_equal(@koyomi, @himekuri)
  end
end