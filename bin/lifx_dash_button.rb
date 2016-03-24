#!/usr/bin/env ruby

# install gem dependencies with:
# gem install packetfu --no-ri --no-rdoc

require "packetfu"
require "net/https"

module LifxDash
  class Toggle

    def initialize(token, selector)
      @token    = token
      @selector = selector
    end

    def toggle
      log "[POST] #{uri}"

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        req = Net::HTTP::Post.new(uri)
        req.add_field "Authorization", "Bearer #{@token}"
        res = http.request(req)

        log "API reply (#{res.code}): #{res.body}"
      end
    end

    private

    def log(message)
      puts "#{Time.now} - #{self.class} - #{message}"
    end

    def uri
      @uri ||= URI("https://api.lifx.com/v1/lights/#{@selector}/toggle")
    end
  end


  class Monitor

    def initialize(mac_address, iface)
      @mac_address = mac_address
      @iface = iface
    end

    def listen(&block)
      # listen to (and parse) packets
      capture.stream.each do |packet|
        pkt = PacketFu::ARPPacket.parse(packet)
        mac = PacketFu::EthHeader.str2mac(pkt.eth_src)

        # check mac address matches and arp opcode is 1
        if mac == @mac_address
          if pkt.arp_opcode == 1
            log pkt.peek
            block.call(pkt)
          end
        end
      end
    end

    private

    def log(message)
      puts "#{Time.now} - #{self.class} - #{message}"
    end

    def capture
      # sniff and filter for ARP packets on the interface
      @capture ||= PacketFu::Capture.new(
        :iface => @iface,
        :start => true,
        :filter => "arp"
      )
    end
  end

  # set up monitor and toggle, then listen for packets
  def self.run(options = {})
    monitor = LifxDash::Monitor.new(options[:mac_address], options.fetch(:iface, "en0"))
    lifx = LifxDash::Toggle.new(options[:lifx_token], options.fetch(:lifx_selector, "all"))

    monitor.listen { |pkt| lifx.toggle }
  end
end


LifxDash.run(
  iface: "en0",
  mac_address: "f0:4f:7c:99:8a:73",
  lifx_token: "c2533f027a1d073ff5cb34cb77ea1e0ae6256c5a290ae7fe2d9bba3698af769d",
  lifx_selector: "d073d501ffd4"
)
