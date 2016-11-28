
case node["platform"]

when "debian", "ubuntu"

	execute "update" do
		command "apt-get update"

	end

	package ["php", "php-mysql"] do
		action :install
	end


	service "php7.0-fpm" do
		action :start
	end	


when "rhel"


## Rhel code here

end
