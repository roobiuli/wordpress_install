
if platform?("ubuntu")
	user = "www-data"
else
	user = "apache"
end






if File.exists?("#{node['www']['dir']}")

	execute "download_wordpress" do
		command "cd #{node['www']['dir']} && wget https://wordpress.org/latest.tar.gz && tar xvfz *.tar.gz"
		creates "#{node['www']['dir']}/latest.tar.gz"
	end
end


if File.exists?("#{node['www']['dir']}/wordpress")

	execute "set_wordpress" do
		command "mv #{node['www']['dir']}/wordpress/* #{node['www']['dir']} ; mv #{node['www']['dir']}/wordpress/.* #{node['www']['dir']}"
		creates "#{node['www']['dir']}/wp-login.php"

	end

	execute "set_ownership_and_clean" do 
		command " chown -R #{user}:#{user} #{node['www']['dir']} && rm -rf #{node['www']['dir']}/*.tar.gz #{node['www']['dir']}/wordpress"
	end

end