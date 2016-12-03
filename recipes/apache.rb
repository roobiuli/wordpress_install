#
# Cookbook Name:: wordpress_install
# Recipe:: apache
#
# Copyright (c) 2016 The Authors, All Rights Reserved.



case node["platform"]
when "ubuntu", "debian"
	apache = "apache2"
	user = "www-data"

	httploc = node['www']['ubuntuapacheloc']

when "suse", "rhel", "centos"
	apache = "httpd"
	user = 'apache'

	httploc = node['www']['fedoraapacheloc']


	file "welcomehttp" do
	path "/etc/httpd/conf.d/welcome.conf"
	action :delete
    end

end

		package "#{apache}" do
			action :install
			if ::File.exists?("/etc/httpd/conf.d/welcome.conf")
				notifies :delete, "file[welcomehttp]", :immediate 
			end
		end

		service "#{apache}" do
			action :start
			supports :start => true, :restart => true

		end




		directory "#{node['www']['dir']}" do
			action :create
			owner "#{user}"
			group "#{user}"
			mode 0644
		end

		template "#{httploc}/000-default.conf" do
			source "000-default.conf.erb"
			action :create
			variables(
				:dir => "#{node['www']['dir']}"
				)
			mode "0644"
			owner "#{user}"
			group "#{user}"
			notifies :reload, "service[#{apache}]"

		end

