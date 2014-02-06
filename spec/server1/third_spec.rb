require 'spec_helper'

describe package('crond') do
  # it { should be_installed }
 it { puts "server_z testing package" }
end

describe service('ntpd') do
  # it { should be_enabled   }
  # it { should_not be_running   }
 it { puts "server_z testing service1" }
 it { puts "server_z testing service2" }

end

# describe port(80) do
#  it { puts "server_z testing port" }
#   # it { should be_listening }
# end

# describe file('/etc/httpd/conf/httpd.conf') do
#   # it { should be_file }
#  it { puts "server_z testing file" }
#  it { puts "server_z testing file1" }
#  it { puts "server_z testing file2" }
#  it { puts "server_z testing file3" }
#   # it { should contain "ServerName vagprovserver_zl100" }
# end
