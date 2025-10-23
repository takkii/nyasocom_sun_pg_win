# frozen_string_literal: true

require 'minitest/autorun'
require 'dotenv'
Dotenv.load

# Mini_test file load.
class VersionTest < Minitest::Test
  def test_version
    # dotenv == string
    @v1 = ENV['NYASOCOMSUN_VERSION']
    @v2 = '3.2'

    assert_equal(@v1, @v2)
  end
end
