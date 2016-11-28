#
# Cookbook Name:: wordpress_install
# Recipe:: basics
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

packages = ["wget", "curl", "vim", "htop"]

packages.each do |name|

package name do
	action :install 
end

end
