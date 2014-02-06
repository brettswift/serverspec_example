require 'spec_helper'

# must have container here otherwise spec helper will create a 
# vagrant box for every describe. (it'll still do that for every test file)
describe "container" do
  describe service('cpuspeed') do
    it { should_not be_running }
    it { puts "server_2 2nd file:  testing cpuspeed" }
  end

  describe service('acpid') do
    # it { should be_enabled   }
    it { should be_running }
    it { puts "server_2 2nd file:  testing acpid" }
    it { puts "server_3 2nd file:  testing acpid again" }
  end
end 