require 'spec_helper'

# must have container here otherwise spec helper will create a 
# vagrant box for every describe. (it'll still do that for every test file)
describe "container" do
  describe package('awk') do
    it { should_not be_installed }
    it { puts "server_2 testing awk" }
  end

  describe service('messagebus') do
    it { should be_running   }
    it { puts "server_2 testing messagebus" }
    it { puts "server_2 testing messagebus again" }

  end
end 