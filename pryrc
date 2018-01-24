irbrc_path = File.expand_path('~/.irbrc')
if File.exist?(irbrc_path)
  begin
    load irbrc_path
  rescue Exception
    warn "Could not load: #{ irbrc_pathj }" # because of $!.message
  end
end
