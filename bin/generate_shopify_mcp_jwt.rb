#!/usr/bin/env ruby
# typed: true
# frozen_string_literal: true

require "bundler/setup"
require "jwt"
require "optparse"
require "json"
require "time"

# Parse command line options
options = {}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: generate_shopify_mcp_jwt.rb [options]"

  opts.on("-s", "--secret SECRET", "Secret key (required)") do |secret|
    options[:secret] = secret
  end

  opts.on("-a", "--app-id APP_ID", "Application ID (required)") do |app_id|
    options[:app_id] = app_id
  end

  opts.on("-S", "--shop-id SHOP_ID", "Shop ID (required)") do |shop_id|
    options[:shop_id] = shop_id
  end

  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit
  end
end

parser.parse!

# Validate required parameters
if options[:secret].nil?
  puts "Error: Secret key is required."
  puts parser.help
  exit 1
end

if options[:app_id].nil?
  puts "Error: Application ID is required."
  puts parser.help
  exit 1
end

if options[:shop_id].nil?
  puts "Error: Shop ID is required."
  puts parser.help
  exit 1
end

# Build JWT payload with standard claims
payload = {
  # Standard claims
  iss: options[:app_id],    # Issuer (using app_id)
  sub: options[:app_id],    # Subject (using app_id)
  sid: options[:shop_id],   # Shop ID
  iat: Time.now.to_i,       # Issued at time
  exp: Time.now.to_i + 3600, # Expiration time (1 hour)
}

# Generate the JWT
begin
  token = JWT.encode(payload, options[:secret], "HS256")
  puts "WARNING: The following JWT token contains sensitive information and should not be shared publicly:"
  puts "----------------------------------------------------------------"
  puts token
  puts "----------------------------------------------------------------"
  puts "This token will expire in 1 hour and is tied to app_id: #{options[:app_id]} and shop_id: #{options[:shop_id]}"
rescue => e
  puts "Error generating JWT: #{e.message}"
  exit(1)
end
