#
# Cookbook Name:: wordpress_install
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

search(:pass, "id:mysql").each do |bag|

#Chef::Log.info("Testing this is pass #{mysql_pass}")

package ["mysql-client", "mysql-server"] do
	action :install
end


service "mysql" do
	action :start
end 

execute "change_mysql_root_pass" do
	command "mysqladmin -u root password \"#{bag['pass']}\""
	not_if { ::File.exists?("/var/lib/mysql/chefconfigured") }

	notifies :restart, 'service[mysql]', :immediate

	end


execute "add_database_user" do
	command "mysql -u root -e 'create database wordpress;' && mysql -u root -e \'CREATE USER 'wp_user'@'localhost' identified by \"#{bag['pass']}\";\'"
	not_if { ::File.exists?("/var/lib/mysql/chefconfigured") }
end

file "/var/lib/mysql/chefconfigured" do
	action :touch
	mode 0664
end

end

