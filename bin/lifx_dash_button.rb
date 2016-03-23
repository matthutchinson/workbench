#!/usr/bin/env ruby

# install gem dependencies with:
# gem install packetfu --no-ri --no-rdoc
# get/set ENV var LIFX_DASH_API_TOKEN at https://cloud.lifx.com/settings

require "packetfu"
require "net/http"
require "net/https"

class LifxDashButton

  def self.run(iface = "en1", lifx_token = '')
    self.new(iface, lifx_token).monitor
  end

  LIFX_DASH_BUTTON_MAC = "f0:4f:7c:99:8a:73"

  def initialize(iface, lifx_token)
    @iface = iface
    @lifx_token = lifx_token
  end

  def toggle_lights
    log 'toggling lights'

    uri = URI("https://api.lifx.com/v1/lights/all/toggle")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Post.new(uri)
    req.add_field "Authorization", "Bearer #{@lifx_token}"
    res = http.request(req)

    log "response HTTP Status Code: #{res.code}"
    log "response HTTP Response Body: #{res.body}"
  end

  def monitor
    # sniff and filter for ARP packets on the interface
    cap = PacketFu::Capture.new(:iface => @iface, :start => true, :filter => "arp")

    # parse packet stream and examime src mac address
    cap.stream.each do |packet|
      pkt     = PacketFu::ARPPacket.parse(packet)
      src_mac = PacketFu::EthHeader.str2mac(pkt.eth_src)

      # pressing the button, we usually get 2 good ARP packets within 5-10
      # seconds of each other, so we flush out others and look for these
      if src_mac == LIFX_DASH_BUTTON_MAC
        if pkt.arp_opcode == 1
          log pkt.peek
          toggle_lights
        end
      end
    end
  end

  private

  def log(message)
    puts "#{Time.now} #{message}"
  end
end

LifxDashButton.run(ARGV[0] || 'en1', ARGV[1])
