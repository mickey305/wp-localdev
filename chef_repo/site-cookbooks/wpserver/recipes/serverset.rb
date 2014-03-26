
# firewall setting
service "iptables" do
	action [:stop, :disable]
end

# httpd setting
service "httpd" do
	action [:start, :enable]
	supports :status => true, :restart => true, :reload => true
end

# mysql setting
service "mysqld" do
	action [:start, :enable]
	supports :status => true, :restart => true, :reload => true
end
# script "mysql" do
# 	interpreter "bash"
# 	user "root"
# 	code <<-EOH
# 		service mysqld start
# 		chkconfig mysqld on
# 	EOH
# end