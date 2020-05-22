#!/usr/bin/ruby

require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require "amazing_print"

loaded                  = []
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000

# use gem install wirble hirb pry pry-nav
%w(wirble hirb pry pry-nav).each do |gem|
  begin
    require gem
    loaded << gem
  rescue LoadError
  end
end

# use Amazing Print
AmazingPrint.irb! if defined?(AmazingPrint)

# configure wirble
if defined?(Wirble)
  Wirble.init
  Wirble.colorize

  colors = Wirble::Colorize.colors.merge({
    :object_class  => :purple,
    :symbol        => :purple,
    :symbol_prefix => :purple
  })

  Wirble::Colorize.colors = colors
end

# enable hirb
if defined?(Hirb)
  Hirb::View.enable
end

# some helper methods
def save_file(data, filename)
  File.open(filename, 'w') { |f| f.write(data) }
end

class Object
  # return a list of methods defined locally for a particular object. Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  # print documentation, use like this;
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    system 'ri', method.to_s
  end
end

# load railsrc if it exists
railsrc_path = File.expand_path('~/.railsrc')

if (ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
    loaded << 'railsrc'
  rescue Exception => e
    puts "Could not load: #{ railsrc_path } - #{e.message}"
  end
end

# explain what loaded OK
puts "> all systems are go #{loaded.join('/') + " " if loaded.length > 0}<"
