#!/usr/bin/env ruby
# Pass in the name of the site you wich to create a cert for

domain_name =  ARGV[0]

if domain_name == nil
  puts "Y U No give me a domain name?"
else
   system "openssl genrsa -out #{domain_name}.key 1024"
   system "openssl req -new -key #{domain_name}.key -out #{domain_name}.csr -subj '/C=US/ST=NJ/L=Monroe/O=MyCompany/OU=IT/CN=#{domain_name}'"
   system "cp #{domain_name}.key #{domain_name}.key.bak"
   system "openssl rsa -in #{domain_name}.key.bak -out #{domain_name}.key"
   system "openssl x509 -req -days 365 -in #{domain_name}.csr -signkey #{domain_name}.key -out #{domain_name}.crt"
   system "mkdir -p /usr/local/etc/nginx/ssl"
   system "mv #{domain_name}.* /usr/local/etc/nginx/ssl"
end
