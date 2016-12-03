#
# Cookbook Name:: wordpress_install
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

case node['platform'] 
when "centos", "rhel"
	mysql = "mysqld"
when "debina", "ubuntu"
	mysql = "mysql"
end

search(:pass, "id:mysql").each do |bag|

#Chef::Log.info("Testing this is pass #{mysql_pass}")

package "mysql-server" do
	action :install
end


execute "start_mysql" do
	command "/etc/init.d/#{mysql} restart"

end

#service "mysql" do
#	name "#{mysql}"
#	supports :reload => true
#	action :start
#end 

execute "change_mysql_root_pass" do
	command "mysqladmin -u root password \"#{bag['pass']}\""
	not_if { ::File.exists?("/var/lib/mysql/chefconfigured") }
# weird stuff in centos	notifies :reload, 'service[mysql]', :immediate

	end
execute "reload" do
	command "/etc/init.d/#{mysql} restart"
	not_if { ::File.exists?("/var/lib/mysql/chefconfigured") }
end


execute "add_database_user" do
	command "mysql -u root -p\"#{bag['pass']}\" -e 'create database wordpress;' && mysql -u root -e \'CREATE USER 'wp_user'@'localhost' identified by \"#{bag['pass']}\";\'"
	not_if { ::File.exists?("/var/lib/mysql/chefconfigured") }
end

file "/var/lib/mysql/chefconfigured" do
	action :touch
	mode 0664
end

end

