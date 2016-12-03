
case node["platform"]

when "debian", "ubuntu"

	execute "update" do
		command "apt-get update"

	end




when "rhel", "centos"

# Rhel code goes here 

end



package ["php", "php-mysql"] do
		action :install

		if node['platform'] == "rhel"
			service "php7.0-fpm" do
			action :start
			end	
		end
	end