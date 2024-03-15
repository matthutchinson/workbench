#!/usr/bin/ruby

begin
  require 'rubygems'
  require 'irb/completion'
  require "amazing_print"
rescue LoadError
end

IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:USE_READLINE] = true
IRB.conf[:BACK_TRACE_LIMIT] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('.irb_history', ENV['HOME'])

# use Amazing Print
AmazingPrint.irb! if defined?(AmazingPrint)

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

# ready!
puts "> all systems are go <"
