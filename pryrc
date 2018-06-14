irbrc_path = File.expand_path('~/.irbrc')
if File.exist?(irbrc_path)
  begin
    load irbrc_path
  rescue Exception
    warn "Could not load: #{ irbrc_path }"
  end
end

if defined?(Rails)
  # show Rails app name and RAILS_ENV name in prompt
  app_env  = (ENV['RAILS_ENV'] || Rails.env)[0...3]
  app_name = Rails.application.class.parent_name.downcase
  prompt   = "#{ app_name }(#{ app_env })"
  Pry.config.prompt = proc { |obj, nest_level, _| "#{prompt}:#{obj}:#{nest_level}> " }
end
