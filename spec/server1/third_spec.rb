require 'spec_helper'

# must have container here otherwise spec helper will create a 
# vagrant box for every describe. (it'll still do that for every test file)
describe "container" do
  describe package('traceroute') do
    it { should be_installed }
    it { puts "server_1 testing traceroute" }
  end

  describe service('ntpd') do
    it { should_not be_running   }
    it { puts "server_1 testing ntpd" }
    it { puts "server_1 testing ntpd again" }

  end

  describe file('/home/vagrant/.bashrc') do
    it { should be_file }
    it { should contain "User specific aliases" }
    it { puts "server_1 testing .bashrc" }
  end
end
