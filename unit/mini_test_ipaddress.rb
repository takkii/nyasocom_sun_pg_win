# frozen_string_literal: true

require 'socket'
require 'minitest/autorun'

# MiniTest, IPAddress.
class IPAddressTest < Minitest::Test

  def list_socket
    Socket.ip_address_list.find do |intf|
    intf.ipv4? && !intf.ipv4_loopback? && !intf.ipv4_multicast?
    end.ip_address
  end

  def eq_socket
    Socket.ip_address_list.find do |ai|
      ai.ipv4? && !ai.ipv4_loopback?
    end.ip_address
  end

  def test_ipaddress
    @v4_1 = list_socket
    @v4_2 = eq_socket

    assert_equal(@v4_1, @v4_2)
  end
end

__END__