#!/usr/bin/env ruby

require 'packetfu'
require 'lifx'

MIN_LIFX_LIGHT_COUNT = 3
LIFX_DASH_BUTTON_MAC = '90:72:40:0b:f2:f4'

# init client
begin
  puts "looking for lights ..."
  client = LIFX::Client.lan
  # # wait to find at least 3 lights
  client.discover! { |c| c.lights.count >= MIN_LIFX_LIGHT_COUNT }
  puts "found lights"
rescue LIFX::Client::DiscoveryTimeout
  puts "sorry, I couldn't find any lights"
  exit 1
end

def toggle_all_lifx_lights(client)
  # toggle all lights on or off
  if client.lights.first.on?
    puts "#{Time.now} - turning lights OFF"
    client.lights.turn_off
  else
    puts "#{Time.now} - turning lights ON"
    client.lights.turn_on
  end

  # ensure all packets are flushed
  client.flush
end


# # sniff and filter for ARP probe packets
cap = PacketFu::Capture.new(:iface => 'en0', :start => true, :filter => 'arp')

cap.stream.each do |pkt|
  # parse packet and examime src mac address
  arpreq  = PacketFu::ARPPacket.parse(pkt)
  src_mac = PacketFu::EthHeader.str2mac(arpreq.eth_src)
  src_ip  = arpreq.arp_src_ip_readable
  if src_mac == LIFX_DASH_BUTTON_MAC
    if arpreq.arp_opcode == 1
      # toggle_all_lifx_lights(client)
      # require 'pry'
      # binding.pry

      puts arpreq.peek_format
      # puts "#{src_mac},#{src_ip}"
    end
  end
end

