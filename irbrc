#!/usr/bin/ruby

require 'rubygems'
require 'irb/completion'

begin
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

#====

# show queries
if defined? ActiveRecord
  ActiveRecord::Base.logger = Logger.new STDOUT
end

# show requests, e.g. use app.get '/'
if defined? ActionController
  ActionController::Base.logger = Logger.new STDOUT
end

# run queries
def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

# get a specific route via index or name
def route(index_or_name)
  case index_or_name
    when Integer
      Rails.application.routes.routes[index_or_name]
    when Symbol # named route
      Rails.application.routes.named_routes.get index_or_name
    end
end

# show Rails app name and env name in prompt
if defined?(Rails)
  app_env  = Rails.env[0...3]
  app_name = if defined?(Rails.application.class.module_parent_name)
               Rails.application.class.module_parent_name
             else
               Rails.application.class.parent_name
             end
  prompt   = "#{app_name}(#{app_env})".downcase

  # build irb prompt
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I    => "#{ prompt }> ",
    :PROMPT_N    => "#{ prompt }| ",
    :PROMPT_C    => "#{ prompt }| ",
    :PROMPT_S    => "#{ prompt }%l ",
    :RETURN      => "=> %s\n",
    :AUTO_INDENT => true,
  }
end

# ready!
puts "> all systems are go <"
