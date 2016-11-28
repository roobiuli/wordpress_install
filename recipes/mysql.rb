#
# Cookbook Name:: wordpress_install
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


package ["mysql-client", "mysql-server"] do
	action :install
end


service "mysql" do
	action :start
end 
