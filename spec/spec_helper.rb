require 'serverspec'
require 'pathname'
require 'net/ssh'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS

def log(first, second = '')
  puts " \e[35m#{first} \e[33m#{second} \e[39m"
end

RSpec.configure do |c|
  # if ENV['ASK_SUDO_PASSWORD']
  #   require 'highline/import'
  #   c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  # else
  #   c.sudo_password = ENV['SUDO_PASSWORD']
  # end
  # c.before :each do
  # log "before each:", " c.host: #{c.host}" " host #{host}"
  # end

  c.before :suite do
    log "","Before suite"
  end
  # c.before :all do
  #   log "","Before all"
  # end
  # c.before :each do
  #   log "Before each"
  # end
  # c.after :each do
  #   log "After each"
  # end
  # c.after :all do
  #   log "","After all"
  # end
  # c.after :suite do
  #   log "After suite"
  # end


  c.before :all do
    block = self.class.metadata[:example_group_block]
    #   if RUBY_VERSION.start_with?('1.8')
    #     file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    #   else
    file = block.source_location.first
    #   end
    host  = File.basename(Pathname.new(file).dirname)
    log "before all: upped  #{host}", " c.host: #{c.host} host #{host} ---- #{file}"

    vagrant_status = `vagrant status #{host}`
    puts vagrant_status
    
    vagrant_up = `vagrant up #{host}`
    log "vagrant up result: " , vagrant_up
    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin
      config = `vagrant ssh-config #{host}` #doesn't work if it's insie the config section
      if config != ''
        config.each_line do |line|
          if match = /HostName (.*)/.match(line)
            host = match[1]
          elsif  match = /User (.*)/.match(line)
            user = match[1]
          elsif match = /IdentityFile (.*)/.match(line)
            options[:keys] =  [match[1].gsub(/"/,'')]
          elsif match = /Port (.*)/.match(line)
            options[:port] = match[1]
          end
        end
      end
      c.ssh   = Net::SSH.start(host, user, options)
    end
  end

  c.after :all do
    block = self.class.metadata[:example_group_block]
    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end
    host  = File.basename(Pathname.new(file).dirname)
    vagrant_destroy = `vagrant destroy #{host} -f`
    log "vagrant up result: " , vagrant_destroy
    log "after all: destroyed #{host}"
    # log "after all", "vagrant destroy #{host} -f"
  end

  c.after :suite do
    log "", "after suite"
    # vagrant_destroy = `vagrant destroy -f`
  end
end
