irbrc_path = File.expand_path('~/.irbrc')
if File.exist?(irbrc_path)
  begin
    load irbrc_path
  rescue Exception
    warn "Could not load: #{ irbrc_path }"
  end
end

if defined?(Rails)
  # show Rails app name and env name in prompt
  app_env  = Rails.env[0...3]
  app_name = if defined?(Rails.application.class.module_parent_name)
               Rails.application.class.module_parent_name
             else
               Rails.application.class.parent_name
             end
  prompt   = "#{app_name}(#{app_env})".downcase
  Pry.config.prompt = proc { |obj, nest_level, _| "#{prompt}:#{obj}:#{nest_level}> " }
end
