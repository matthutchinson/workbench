#!/usr/bin/env ruby

# install gem dependencies with:
# gem install daemons packetfu --no-ri --no-rdoc
# get/set ENV var LIFX_DASH_API_TOKEN at https://cloud.lifx.com/settings

require "packetfu"
require "net/http"
require "net/https"
require "daemons"
require "logger"

class LifxDashButton

  def self.run
    self.new(iface: ARGV[0]).monitor
  end

  BROADCAST_ARP_DST_IP = "10.0.1.18"
  LIFX_DASH_BUTTON_MAC = "90:72:40:0b:f2:f4"
  FLUSH_PACKET_SECONDS = 30

  def initialize(iface: "en1")
    @iface         = iface
    @arp_packets   = []
    @last_flush_at = Time.now.to_i
    log_file       = File.open("/usr/local/var/log/lifx_dash_button.log", File::WRONLY | File::APPEND | File::CREAT)
    @logger        = Logger.new(log_file)
  end

  def toggle_lights
    log 'toggling lights'

    uri = URI("https://api.lifx.com/v1/lights/all/toggle")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    req = Net::HTTP::Post.new(uri)
    req.add_field "Authorization", "Bearer #{ENV['LIFX_DASH_API_TOKEN']}"
    res = http.request(req)

    log "response HTTP Status Code: #{res.code}"
    log "response HTTP Response Body: #{res.body}"
  end

  def enough_packets?
    @arp_packets.length > 1
  end

  def flush_packets
    if @arp_packets.any?
      log "flushing #{@arp_packets.length} packets"
      @arp_packets = []
    end
    @last_flush_at = Time.now.to_i
  end

  def should_flush_packets?
    Time.now.to_i > (@last_flush_at + FLUSH_PACKET_SECONDS)
  end

  def monitor
    Daemons.call do
      # sniff and filter for ARP packets on the interface
      cap = PacketFu::Capture.new(:iface => @iface, :start => true, :filter => "arp")

      # parse packet stream and examime src mac address
      cap.stream.each do |packet|
        flush_packets if should_flush_packets?

        pkt     = PacketFu::ARPPacket.parse(packet)
        src_mac = PacketFu::EthHeader.str2mac(pkt.eth_src)
        dst_ip  = pkt.arp_dst_ip_readable

        # pressing the button, we usually get 2 good ARP packets within 5-10
        # seconds of each other, so we flush out others and look for these
        if src_mac == LIFX_DASH_BUTTON_MAC && (dst_ip == BROADCAST_ARP_DST_IP)
          if pkt.arp_opcode == 1
            @arp_packets << dst_ip
            log pkt.peek
            if enough_packets?
              toggle_lights
              flush_packets
            end
          end
        end
      end
    end
  end

  private

  def log(message)
    @logger.info "#{Time.now} #{message}"
  end
end

LifxDashButton.run
