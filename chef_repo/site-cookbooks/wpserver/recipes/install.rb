# vim php(old) mysql-server httpd(apache) package and more install
#
# mysql server 5.1.7
# php          5.3.3
# vim          7.2.4
# apache       2.2.1
%w{
	vim-enhanced
	php
	php-xml
	php-common
	php-mbstring
	php-devel
	php-process
	php-cli
	php-pear
	php-mysql
	mysql-server
	mysql-devel
	httpd
}.each do |i|
	e = package i do
		action :nothing
	end
	e.run_action(:install)
end
# git install(old version)
#
# git          1.7.1
e = script "install_git" do
	interpreter "bash"
	user "root"
	code "yum -y install git"
	not_if {File.exist?("/usr/bin/git")}
	action :nothing
end
e.run_action(:run)
# zip, unzip install
#
# zip          3.0
# unzip        6.0
e = script "install_zip" do
	interpreter "bash"
	user "root"
	code "yum -y install zip"
	not_if {File.exist?("/usr/bin/zip")}
	action :nothing
end
e.run_action(:run)
e = script "install_unzip" do
	interpreter "bash"
	user "root"
	code "yum -y install unzip"
	not_if {File.exist?("/usr/bin/unzip")}
	action :nothing
end
e.run_action(:run)





chef_gem "mysql" do
	action :install
	#subscribes :install, "package[mysql-devel]", :immediately
end

