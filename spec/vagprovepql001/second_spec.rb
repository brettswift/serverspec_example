require 'spec_helper'

describe package('httpd') do
  # it { should be_installed }
 it { puts "epq 2nd:  testing package" }
end

describe service('httpd') do
  # it { should be_enabled   }
  # it { should be_running   }
 it { puts "epq 2nd:  testing service1" }
 it { puts "epq 2nd:  testing service2" }

end

describe port(80) do
 it { puts "epq 2nd:  testing port" }
  # it { should be_listening }
end

describe file('/etc/httpd/conf/httpd.conf') do
  # it { should be_file }
 it { puts "epq 2nd:  testing file" }
 it { puts "epq 2nd:  testing file1" }
 it { puts "epq 2nd:  testing file2" }
 it { puts "epq 2nd:  testing file3" }
  # it { should contain "ServerName vagprovepq 2nd: l100" }
end
