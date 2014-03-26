


# create wp config file(using wp-config-sample.php version3.8)
e = template "wp-config.php" do
	path "/vagrant/wordpress/wp-config.php"
	source "wp-config.php.erb"
	mode 00644
	action :nothing
	variables(
		:key_auth    => node['wpserver']['wp']['key-auth'],
		:key_secure  => node['wpserver']['wp']['key-secure'],
		:key_logged  => node['wpserver']['wp']['key-logged'],
		:key_nonce   => node['wpserver']['wp']['key-nonce'],
		:salt_auth   => node['wpserver']['wp']['salt-auth'],
		:salt_secure => node['wpserver']['wp']['salt-secure'],
		:salt_logged => node['wpserver']['wp']['salt-logged'],
		:salt_nonce  => node['wpserver']['wp']['salt-nonce']
	)
	not_if {File.exist?("/vagrant/wordpress/wp-config.php")}
end
e.run_action(:create)





# # template rewrite files
# create index file
e = template "index.html" do
	path "/vagrant/index.html"
	source "index.html.erb"
	mode 0644
	action :nothing
end
e.run_action(:create)
# create error documents
%w{
	unauthorized.html
	forbidden.html
	notfound.html
	intserverr.html
}.each do |j|
	e = template j do
		path "/vagrant/er/" + j
		source j + ".erb"
		mode 0644
		action :nothing
	end
	e.run_action(:create)
end


# rewrite apache setting(using httpd.conf by apache2.x)
template "httpd.conf" do
	path "/etc/httpd/conf/httpd.conf"
	source "httpd.conf.erb"
	mode 0644
	notifies :restart, "service[httpd]"
end
# ctreate .htaccess file
template ".htaccess" do
	path "/vagrant/.htaccess"
	source ".htaccess.erb"
	mode 0604
	notifies :restart, "service[httpd]"
	if !node['htaccess']['xmlrpc-permit-flag'] then
		if node['htaccess']['xmlrpc-permit-ip'] == node['wpserver']['into']['nonspace'] then
			variables(
				:xmlfileorder  => node['wpserver']['ht-permission']['order']['false'],
				:xmlpermission => node['wpserver']['ht-permission']['false'],
				:permitip      => node['wpserver']['into']['nonspace']
			)
		else
			variables(
				:xmlfileorder  => node['wpserver']['ht-permission']['order']['false'],
				:xmlpermission => node['wpserver']['ht-permission']['false'],
				:permitip      => node['wpserver']['ht-permission']['permit-from']+node['htaccess']['xmlrpc-permit-ip']
			)
		end
	else
		variables(
			:xmlfileorder  => node['wpserver']['ht-permission']['order']['true'],
			:xmlpermission => node['wpserver']['ht-permission']['true'],
			:permitip      => node['wpserver']['into']['nonspace']
		)
	end
end

