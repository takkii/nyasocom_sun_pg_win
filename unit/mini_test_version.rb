# frozen_string_literal: true

require 'minitest/autorun'
require 'dotenv'
Dotenv.load

# Version Test in .env == String
class VersionTest < Minitest::Test
  def test_version
    # dotenv == String type, version number.
    @v1 = ENV['NYASOCOMSUN_VERSION']
    @v2 = '3.2'

    assert_equal(@v1, @v2)
  end
end

__END__