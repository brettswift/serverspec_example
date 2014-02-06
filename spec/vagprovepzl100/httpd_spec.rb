require 'spec_helper'

describe package('httpd') do
  # it { should be_installed }
 it { puts "epz testing package" }
end

describe service('puppet') do
  # it { should be_enabled   }
  it { should_not be_running   }
 it { puts "epz testing service1" }
 it { puts "epz testing service2" }

end

describe port(80) do
 it { puts "epz testing port" }
  # it { should be_listening }
end

describe file('/etc/httpd/conf/httpd.conf') do
  # it { should be_file }
 it { puts "epz testing file" }
 it { puts "epz testing file1" }
 it { puts "epz testing file2" }
 it { puts "epz testing file3" }
  # it { should contain "ServerName vagprovepzl100" }
end
