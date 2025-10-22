# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require 'minitest/autorun'
require 'version'

# Mini_test file load.
class VersionTest < Minitest::Test
  def test_version
    @v1 = EngineLeft.version
    version = '5.0.0'
    t = Date.today
    build_day = t.strftime('%Y.%m.%d')
    @v2 = "#{version}-#{build_day}".freeze

    refute_equal(@v1, @v2)
    assert_operator(@v1, :<, @v2)
  end
end
