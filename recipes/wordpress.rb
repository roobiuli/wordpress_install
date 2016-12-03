
if platform?("ubuntu")
	user = "www-data"
else
	user = "apache"
end





bash "download_wp" do
		cwd "#{node['www']['dir']}"
		code "wget https://wordpress.org/latest.tar.gz && tar xvfz *.tar.gz && mv wordpress/* . && chown -R #{user}:#{user} *"
		creates "#{node['www']['dir']}/latest.tar.gz"


	end



#if File.exists?("#{node['www']['dir']}")

#	execute "download_wordpress" do
#		command "cd #{node['www']['dir']} && wget https://wordpress.org/latest.tar.gz"
#		creates "#{node['www']['dir']}/latest.tar.gz"
#	end

	

	#execute "extract_wp" do
	#	command "cd #{node['www']['dir']} && tar xvfz *.tar.gz"
	#end

#end

#bash "extract_wp" do
#	cwd "#{node['www']['dir']}"
	#code "tar xvfz *.tar.gz"

	#end

#if File.exists?("#{node['www']['dir']}/wordpress")

	#execute "set_wordpress" do
	#	command "mv #{node['www']['dir']}/wordpress/* #{node['www']['dir']} && mv #{node['www']['dir']}/wordpress/.* #{node['www']['dir']}"
	#	not_if { ::File.exists?("#{node['www']['dir']}/wp-login.php") }

	#end

	#execute "set_ownership" do 
	#	command " chown -R #{user}:#{user} #{node['www']['dir']}"
	#end

	#execute "clean_wp" do
	#	command "rm -rf #{node['www']['dir']}/*.tar.gz #{node['www']['dir']}/wordpress"
	#end

#end