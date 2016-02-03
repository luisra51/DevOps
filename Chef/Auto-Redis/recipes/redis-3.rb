bash 'Compilando Redis 3.0.0' do
        extract_path = '/opt/redis/'
        src_filename = '/opt/redis-3.0.0.tar.gz'

        if File.exist?('/usr/local/bin/redis-cli')
                code <<-EOH
                        redis-cli --version > /opt/Redis_`date +%d-%m-%y`.log 
                EOH
        else
                code <<-EOH
                        cd /opt/
                        wget http://download.redis.io/releases/redis-3.0.0.tar.gz
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
