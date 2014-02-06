require 'spec_helper'

describe package('cpuspeed') do
  # it { should be_installed }
 it { puts "server_q 2nd spec.rb:  testing package" }
end

describe service('acpid') do
  # it { should be_enabled   }
  # it { should be_running   }
 it { puts "server_q 2nd spec.rb:  testing service1" }
 it { puts "server_q 2nd spec.rb:  testing service2" }

end

# describe port(80) do
#  it { puts "server_q 2nd spec.rb:  testing port" }
#   # it { should be_listening }
# end

# describe file('/etc/httpd/conf/httpd.conf') do
#   # it { should be_file }
#  it { puts "server_q 2nd spec.rb:  testing file" }
#  it { puts "server_q 2nd spec.rb:  testing file1" }
#  it { puts "server_q 2nd spec.rb:  testing file2" }
#  it { puts "server_q 2nd spec.rb:  testing file3" }
#   # it { should contain "ServerName vagprovepq 2nd spec.rb: l100" }
# end
