#
# Cookbook Name:: webapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

## WorkStation included
# vagrant     1.4.0
# virtualbox  4.3.4
# chef        11.10.4
# centos      6.4 minimal-x86_64 box
# wordpress   3.8


require 'timeout'



include_recipe "wpserver::install"

include_recipe "wpserver::serverset"

include_recipe "wpserver::mysql-relation"



# 
# Dangerous(critical) zone
#
e = script "mkdir-/tmp/wpbu" do
	interpreter "bash"
	user "root"
	code "mkdir /tmp/wpbu/"
	action :nothing
	not_if {File.exist?("/tmp/wpbu")}
end
e.run_action(:run)
if node['pkg-wp']['update-flag'] then
	if !node['wpserver']['save-content']['name'].empty? then
		node['wpserver']['save-content']['name'].each do |tmpa|
			e = script "copy_#{tmpa}_to-tmp" do
				interpreter "bash"
				user "root"
				code "cp -fR /vagrant/wordpress/#{tmpa} /tmp/wpbu/"
				action :nothing
				only_if {File.exist?("/vagrant/wordpress/#{tmpa}")}
			end
			e.run_action(:run)
		end
	end
else
	e = script "copy_wpdir_to-tmp" do
		interpreter "bash"
		user "root"
		code "cp -fR /vagrant/wordpress/ /tmp/wpbu/"
		action :nothing
		only_if {File.exist?("/vagrant/wordpress/")}
	end
	e.run_action(:run)
end
# # del default file /var/www/html and grants.sql
# # link from /vagrant to /var/www/html
# # make /var/www/html/er and /var/www/html/wordress directories
e = script "link_htmldir_andmore" do
	interpreter "bash"
	user "root"
	code <<-EOL
		rm -rf /var/www/html /vagrant/er /vagrant/wordpress
		ln -fs /vagrant /var/www/html
		mkdir /vagrant/{er,wordpress}
	EOL
	action :nothing
end
e.run_action(:run)





include_recipe "wpserver::wp-relation"






if node['pkg-wp']['update-flag'] then

	if !node['wpserver']['save-content']['name'].empty? then

		# copy back up file
		node['wpserver']['save-content']['name'].each do |tmpb|
			e = script "copy_#{tmpb}" do
				interpreter "bash"
				user "root"
				code <<-EOF
					cp -fR /tmp/wpbu/#{tmpb} /vagrant/wordpress/
					rm -rf /tmp/wpbu/#{tmpb}
				EOF
				action :nothing
				only_if {File.exist?("/tmp/wpbu/#{tmpb}")}
			end
			e.run_action(:run)
		end

	end

else

	e = script "copy_wpdir" do
		interpreter "bash"
		user "root"
		code <<-EOF
			cp -fR /tmp/wpbu/wordpress/ /vagrant/
			rm -rf /tmp/wpbu/wordpress/
		EOF
		action :nothing
		only_if {File.exist?("/tmp/wpbu/wordpress/")}
	end
	e.run_action(:run)

end




include_recipe "wpserver::templatefiles"





# include_recipe "wpserver::testsample"


