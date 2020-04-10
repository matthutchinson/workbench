irbrc_path = File.expand_path('~/.irbrc')
if File.exist?(irbrc_path)
  begin
    load irbrc_path
  rescue Exception
    warn "Could not load: #{ irbrc_path }"
  end
end

if Pry::Prompt[:rails]
  Pry.config.prompt = Pry::Prompt[:rails]
end
