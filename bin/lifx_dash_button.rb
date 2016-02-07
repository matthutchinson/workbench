#!/usr/bin/env ruby

# install gem dependencies with:
# gem install packetfu fallen --no-ri --no-rdoc
# get/set ENV var LIFX_DASH_API_TOKEN at https://cloud.lifx.com/settings

require "packetfu"
require "fallen"
require "net/http"
require "net/https"

class LifxDashButton

  extend Fallen

  def self.run
    debug = ARGV.any? { |arg| arg.include?('debug') }
    self.new(iface: ARGV[0], debug: debug).monitor
  end

  BROADCAST_ARP_DST_IP = "10.0.1.18"
  LIFX_DASH_BUTTON_MAC = "90:72:40:0b:f2:f4"

  def initialize(iface: "en1", debug: false)
    @iface       = iface
    @debug       = debug
    @arp_packets = []
  end

  def toggle_lights
    debug 'toggling lights'

    uri = URI("https://api.lifx.com/v1/lights/all/toggle")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Post.new(uri)
    req.add_field "Authorization", "Bearer #{ENV['LIFX_DASH_API_TOKEN']}"
    res = http.request(req)

    debug "response HTTP Status Code: #{res.code}"
    debug "response HTTP Response Body: #{res.body}"
  end

  def enough_packets?
    @arp_packets.select { |p| p == BROADCAST_ARP_DST_IP }.length > 1
  end

  def monitor
    # sniff and filter for ARP packets on the interface
    cap = PacketFu::Capture.new(:iface => @iface, :start => true, :filter => "arp")

    # parse packet stream and examime src mac address
    cap.stream.each do |packet|
      pkt     = PacketFu::ARPPacket.parse(packet)
      src_mac = PacketFu::EthHeader.str2mac(pkt.eth_src)

      # since we usually get 2 ARP packets at the same time
      if src_mac == LIFX_DASH_BUTTON_MAC &&
        if pkt.arp_opcode == 1
          @arp_packets << pkt.arp_dst_ip_readable
          debug pkt.peek
          if enough_packets?
            toggle_lights
            @arp_packets = []
          end
        end
      end
    end
  end

  private

  def debug(message)
    puts "#{Time.now} #{message}" if @debug
  end
end

LifxDashButton.run

# LifxDashButton.pid_file "/usr/local/var/run/lifx_dash_button.pid"
# LifxDashButton.stdout "/usr/local/var/log/lifx_dash_button.log"
# LifxDashButton.daemonize!
# LifxDashButton.start!
