#!/usr/bin/env ruby

# install dependencies with:
# gem install packetfu lifx-gem fallen --no-ri --no-rdoc

require "packetfu"
require "lifx"
require "fallen"

class LifxDashButton

  extend Fallen

  def self.run
    self.new(iface: ARGV[0]).monitor
  end

  MIN_LIFX_LIGHT_COUNT = 4
  GUARD_TIME_SECONDS   = 5
  LIFX_DASH_BUTTON_MAC = "90:72:40:0b:f2:f4"

  def initialize(iface: "en1")
    @client = LIFX::Client.lan
    @iface  = iface
  end

  def monitor
    find_lights
    sniff_arp
  end

  def find_lights
    puts "looking for lights ..."
    # # wait to find all lights
    @client.discover! { |c| c.lights.count >= MIN_LIFX_LIGHT_COUNT }
    puts "found lights"
  rescue LIFX::Client::DiscoveryTimeout
    puts "sorry, I couldn't find any lights"
    exit 1
  end

  def toggle_lights
    # toggle all lights on or off, always send OFF if any are ON
    if @client.lights.any? { |light| light.on? }
      puts "#{Time.now} - turning lights OFF"
      @client.lights.turn_off
    elsif @client.lights.all? { |light| light.off? }
      puts "#{Time.now} - turning lights ON"
      @client.lights.turn_on
    else
      puts "be paitent, i'm still sending packets to your lights"
    end

    # ensure all packets are flushed
    @client.flush
  end

  def sniff_arp
    # sniff and filter for ARP packets on the interface
    cap = PacketFu::Capture.new(:iface => @iface, :start => true, :filter => "arp")
    first_arp_at = 0

    # parse packet stream and examime src mac address
    cap.stream.each do |packet|
      break unless self.class.running?
      pkt     = PacketFu::ARPPacket.parse(packet)
      src_mac = PacketFu::EthHeader.str2mac(pkt.eth_src)

      # since we usually get 2 ARP packets at the same time, compare time
      if src_mac == LIFX_DASH_BUTTON_MAC &&
        Time.now.to_i > (first_arp_at + GUARD_TIME_SECONDS)
        if pkt.arp_opcode == 1

          puts "#{Time.now.to_i} -- #{pkt.peek}"
          toggle_lights
          first_arp_at = Time.now.to_i
        end
      end
    end
  end
end

# LifxDashButton.new(iface: ARGV[0]).monitor

LifxDashButton.pid_file "/usr/local/var/run/lifx_dash_button.pid"
LifxDashButton.stdout "/usr/local/var/log/lifx_dash_button.log"
LifxDashButton.daemonize!
LifxDashButton.start!
