# frozen_string_literal: true

require 'core'
require 'himekuri'
require 'minitest/autorun'
require 'time'

# rubygems/grouse and rubygems/sheltered-girl
class HimekuriTest < Minitest::Test
  def test_himekuri
    # koyomi in CoreNYM == himekuri in HimekuriClass
    @koyomi = CoreNYM.koyomi
    @himekuri = HimekuriClass.new.himekuri

    # When failed is contain zero value, example 01 ~ 09 etc.
    assert_equal(@koyomi, @himekuri)
  end
end