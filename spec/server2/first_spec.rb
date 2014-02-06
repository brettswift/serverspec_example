require 'spec_helper'

describe package('crond') do
  # it { should be_installed }
 it { puts "server_q testing package" }
end

describe service('messagebus') do
  # it { should be_enabled   }
  # it { should_not be_running   }
 it { puts "server_q testing service1" }
 it { puts "server_q testing service2" }

end

# describe port(80) do
#  it { puts "epq testing port" }
#   # it { should be_listening }
# end

# describe file('/etc/httpd/conf/httpd.conf') do
#   # it { should be_file }
#  it { puts "epq testing file" }
#  it { puts "epq testing file1" }
#  it { puts "epq testing file2" }
#  it { puts "epq testing file3" }
#   # it { should contain "ServerName vagprovepql100" }
# end
