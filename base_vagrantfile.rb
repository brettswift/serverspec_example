# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.4.0'

# unless Vagrant.has_plugin?("vagrant-librarian-puppet") then
#   raise "please run: `vagrant plugin install vagrant-librarian-puppet` as this plugin is required."
# end

# Vagrant file inspiration:
#         https://gist.github.com/dustinmm80/6568109
#         http://architects.dzone.com/articles/dynamic-vagrant-nodes


# Example box JSON schema
# {
#     :name => :name_of_vagrant_box, #REQUIRED
#     :ip => '10.0.0.11',
#     :synced_folders => [
#         { '.' => '/home/vagrant/myapp' }
#     ],
#     :commands => [
#         'touch /tmp/myfile'
#     ],
#     :vbox_config => [
#         { '--memory' => '1536' }
#     ]
# }



#box without puppet installed - coincides with ./bootstraps/  scripts.  Use this if no PE 3.x .box file exists
#http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box
#latest box with PE 3.0.1 used by TT core.
vagrant_box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box'
vagrant_box_name = 'centos-64-x64-vbox4210-nocm.box'

defaults = {
  :ip            => '33.33.34.',
  :box           => vagrant_box_name,
  :box_url       => vagrant_box_url,
  :ram           => '512',
  :forward_agent => false,
  :forward_x11   => true,
}

domain = 'citest'

puppet_nodes = []
subnet=10
$nodes.each { |inode|
  unless inode.has_key?(:ip) then
    defaults[:ip] = "33.33.34.#{subnet}"
    subnet += 1
  end
  inode = defaults.merge(inode)
  puppet_nodes << inode
}


### Select flavour of puppet ####
use_puppet_enterprise='yes'

# uncomment the below to see the ips for each host
puts 'Node Details:'
puppet_nodes.each { |n| puts " \e[35m#{n[:ip]}\e[39m : \e[33m#{n[:shortname]} : \e[39m#{n[:hostname]}" }
puts ''

Vagrant.configure('2') do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:shortname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.host_name = "#{node[:hostname]}.#{domain}"
      node_config.vm.network :private_network, ip: node[:ip]
      node_config.vm.box_url = node[:box_url]
      node_config.ssh.forward_agent = node[:forward_agent]
      node_config.ssh.forward_x11 = node[:forward_x11]

      if node[:fwdhost]
        node_config.vm.forward_port(node[:fwdguest], node[:fwdhost])
      end

      if use_puppet_enterprise == 'no' then
        #bootstraps with Puppet Open Source
        node_config.vm.provision :shell, :path => '../puppetconfig/vagrant/bootstraps/puppet-bootstrap/bootstrap-puppet-oss.sh'
      else
        #If working outside VPN, and you want PE to come from Dropbox:
        #requires PE to be in ./{file_3.1.0}.tar.gz  path within ~/Dropbox/Puppet
        #ie:  ~/Dropbox/Puppet/puppet-enterprise-3.1.0-el-6-x86_64.tar.gz
        # node_config.vm.synced_folder '~/Dropbox/Puppet', '/tmp/puppet/pe/'
        # node_config.vm.provision :shell, :path => "bootstraps/dropbox-bootstrap-puppet-enterprise.sh"

        # node_config.vm.provision :shell, :path => "../puppetconfig/vagrant/bootstraps/bootstrap-puppet-enterprise.sh"
      end

      # # Puppet Enterprise locations
      # node_config.vm.synced_folder '../../manifests', '/etc/puppetlabs/puppet/environments/master/manifests'
      # node_config.vm.synced_folder '../../modules', '/etc/puppetlabs/puppet/environments/master/modules'
      # node_config.vm.synced_folder '../../hieradata', '/etc/puppetlabs/puppet/environments/master/hieradata'

      # node_config.vm.synced_folder '../../', '/vagrant'

      # node_config.vm.provision :shell, :path => '../../vagrant/bootstraps/vagrant-bootstrap.sh'

      # node_config.vm.provision :puppet  do |puppet|
      #   puppet.options = '--environment master --detailed-exitcodes --verbose --trace --modulepath=/etc/puppetlabs/puppet/modules/:/etc/puppetlabs/puppet/environments/master/modules'
      #   puppet.manifests_path = '../../manifests'
      #   puppet.manifest_file  = 'site.pp'
      # end

      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node[:hostname],
          '--memory', node[:ram],
        ]
      end
    end
  end
end
