#
# Cookbook Name:: wordpress_install
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe "wordpress_install::basics"
include_recipe "wordpress_install::apache"
include_recipe "wordpress_install::php"
