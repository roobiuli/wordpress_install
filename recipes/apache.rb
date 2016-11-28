#
# Cookbook Name:: wordpress_install
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

case node["platform"]
when "ubuntu", "debian"
	apache = "apache2"
	user = "www-data"
when "suse", "redhat"
	apache = "httpd"
	user = "apache"
end

		package apache do
			action :install
		end

		service apache do
			action :start
		end




		directory "#{node['www']['dir']}" do
			action :create
			owner "#{user}"
			group "#{user}"
			mode 0644
		end

		template "#{node['www']['ubuntuapacheloc']}/000-default.conf" do
			source "000-default.conf.erb"
			mode "0644"
			owner "#{user}"
			group "#{user}"
			notifies :restat, "service[#{apache}]"

		end

