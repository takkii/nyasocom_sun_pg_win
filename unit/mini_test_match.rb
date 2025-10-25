# frozen_string_literal: true

require 'minitest/autorun'

# Match Test
class MatchTest < Minitest::Test
  def test_match
    ng_word = 'nonoichi'.to_s
    pattern = /#{ng_word}/o
    message = 'NG'

    assert_match(pattern, ng_word, message)
  end
end