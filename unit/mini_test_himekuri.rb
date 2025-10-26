# frozen_string_literal: true

require 'grouse'
require 'himekuri'
require 'minitest/autorun'
require 'time'

# rubygems/grouse and rubygems/sheltered-girl
class HimekuriTest < Minitest::Test
  def test_himekuri
    # koyomi in module == himekuri in HimekuriClass
    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]

    if /[0-9]+/o == (dt.sec).to_i
      @koyomi = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "0#{dt.hour}時" + "0#{dt.min}分" + "0#{dt.sec}秒" + ' : '.to_s + week + "曜日"
    else
      @koyomi = koyomi
    end

    @himekuri = HimekuriClass.new.himekuri

    # When failed is contain zero value, example 01 ~ 09 etc.
    assert_equal(@koyomi, @himekuri)
  end
end