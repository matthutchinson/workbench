#!/usr/bin/env ruby

require 'packetfu'
require 'lifx'

MIN_LIFX_LIGHT_COUNT = 3
LIFX_DASH_BUTTON_MAC = 'ab:cd:ef:gh'

# # init client
begin
  puts "looking for lights ..."
  client = LIFX::Client.lan
  # # wait to find at least 3 lights
  client.discover! { |c| c.lights.count >= MIN_LIFX_LIGHT_COUNT }
  puts "found #{client.lights.length} lights"
rescue LIFX::Client::DiscoveryTimeout
  puts "sorry, I couldn't find any lights"
  exit 1
end

def toggle_all_lifx_lights(client)
  # toggle all lights on or off
  if client.lights.first.on?
    puts "#{Time.now} - turning lights OFF"
    client.lights.turn_off!
  else
    puts "#{Time.now} - turning lights ON"
    client.lights.turn_on!
  end

  # ensure all packets are flushed
  client.flush
end

# sniff and filter for ARP probe packets
cap = PacketFu::Capture.new(:iface=>'en0', :start=>true, :filter=>'arp')

cap.stream.each do |pkt|
  # parse packet and examime src mac address
  arpreq  = PacketFu::ARPPacket.parse(pkt)
  src_mac = PacketFu::EthHeader.str2mac(arpreq.eth_src)
  src_ip  = arpreq.arp_src_ip_readable
  # if src_ip = '0.0.0.0'
  # if src_mac = LIFX_DASH_BUTTON_MAC
    # toggle_all_lifx_lights(client)
    puts "#{src_mac},#{src_ip}"
  # end
end

