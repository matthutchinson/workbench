# use gem install wirble hirb awesome_print pry pry-doc pry-nav
require 'rubygems'

@loaded = []

# awesome print
begin
  require 'awesome_print'
  @loaded << 'ap'
rescue
end

# handy methods
def save_to(filename, data) 
  file = File.new(filename, "w")
  file.write(data.to_s)
  file.close
end

# load pry
begin
  require 'pry'
  @loaded << 'pry'
rescue 
end

# load wirble
begin
  require 'wirble'
  Wirble.init
  Wirble.colorize

  colors = Wirble::Colorize.colors.merge({
    :object_class => :purple,
    :symbol => :purple,
    :symbol_prefix => :purple
  })
  Wirble::Colorize.colors = colors
  @loaded << 'wirble'
rescue
end

# load hirb
begin 
  require 'hirb'
  Hirb::View.enable
  @loaded << 'hirb'
rescue
end

IRB.conf[:AUTO_INDENT] = true

# load railsrc if it exists
railsrc_path = File.expand_path('~/.railsrc')
if (ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
    @loaded += %w(railsrc sql routes)
  rescue Exception
    warn "Could not load: #{ railsrc_path }" # because of $!.message
  end
end

puts "> all systems are go #{@loaded.join('/') if @loaded.length > 0} <"
