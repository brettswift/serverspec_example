require 'spec_helper'

describe "test1" do
  describe package('crond') do
    # it { should be_installed }
    it { puts "server_2 testing package" }
  end

  describe service('messagebus') do
    # it { should be_enabled   }
    # it { should_not be_running   }
    it { puts "server_2 testing servicea" }
    it { puts "server_2 testing serviceb" }

  end

  # require_relative 'second.rb'
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
