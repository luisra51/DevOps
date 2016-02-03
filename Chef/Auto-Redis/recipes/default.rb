#
# Cookbook Name:: Auto-Redis
# Recipe:: default
#
# Copyright 2016, Luis_R_Sanchez_H
#

execute 'Actualizando el Sistema' do
	case node[:platform]
  		when 'centos','redhat','fedora','suse'
    			command 'yum check-update ; yum upgrade -y'
        		action :run
  		when 'debian','ubuntu'
			command 'apt-get update'
  			action :run
  	end
end

package 'Instalando lo Necesario' do
       	case node[:platform]
                when 'centos','redhat','fedora','suse'
			package_name ['gcc', 'make', 'gcc-c++', 'kernel-devel', 'wget']
                when 'debian','ubuntu'
                        package_name 'build-essential'
                        action :install
        end
end

bash 'Compilando Redis' do
	extract_path = '/opt/redis/'
	src_filename = '/opt/redis-2.8.0.tar.gz'

	if File.exist?('/usr/local/bin/redis-cli')
		code <<-EOH 
			redis-cli --version > /opt/Redis_`date +%d-%m-%y`.log 
		EOH
	else
		code <<-EOH
			cd /opt/
    			wget http://download.redis.io/releases/redis-2.8.0.tar.gz
    			mkdir -p #{extract_path}
    			tar xzf #{src_filename} -C #{extract_path}
    			mv #{extract_path}/*/* #{extract_path}/
    			cd #{extract_path}
    			make
    			make test
    			make install
    			cd utils
    			./install_server.sh 
    		EOH
	end
end

