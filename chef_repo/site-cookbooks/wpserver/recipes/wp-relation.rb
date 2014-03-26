##
# install wordpress
#
#
#
#
e = script "mkdir-/tmp/wp" do
	interpreter "bash"
	user "root"
	code "mkdir /tmp/wp/"
	action :nothing
	not_if {File.exist?("/tmp/wp/")}
end
e.run_action(:run)

e = remote_file "/tmp/wp/#{node['pkg-wp']['version']}#{node['pkg-wp']['ext']}" do
	source "#{node['pkg-wp']['url']}#{node['pkg-wp']['version']}#{node['pkg-wp']['ext']}"
	action :nothing
	not_if {File.exist?("/tmp/wp/#{node['pkg-wp']['version']}#{node['pkg-wp']['ext']}")}
end
e.run_action(:create)

if node['pkg-wp']['update-flag'] then
	e = script "delete-/tmp/wp/wordpress" do
		interpreter "bash"
		user "root"
		code "rm -rf /tmp/wp/wordpress"
		action :nothing
		only_if {File.exist?("/tmp/wp/wordpress/")}
	end
	e.run_action(:run)
end

if node['pkg-wp']['ext'] == '.zip' then
	e = script "unzip-wp" do
		interpreter "bash"
		user "root"
		code "unzip /tmp/wp/#{node['pkg-wp']['version']}#{node['pkg-wp']['ext']} -d /tmp/wp/"
		action :nothing
		not_if {File.exist?("/tmp/wp/wordpress/")}
	end
	e.run_action(:run)
elsif node['pkg-wp']['ext'] == '.tar.gz' then
	e = script "uncomp-wp" do
		interpreter "bash"
		user "root"
		code "tar xzf /tmp/wp/#{node['pkg-wp']['version']}#{node['pkg-wp']['ext']} -C /tmp/wp/"
		action :nothing
		not_if {File.exist?("/tmp/wp/wordpress/")}
	end
	e.run_action(:run)
else
	# put error log
	print "\e[31m"
	puts "--------- extension setting error happened"
	puts "--------- please check the json file \"[ssh-name].json\""
	print "\e[0m"
end

if node['pkg-wp']['update-flag'] then
	e = script "cp wordpress" do
		interpreter "bash"
		user "root"
		code "cp -fR /tmp/wp/wordpress /vagrant"
		action :nothing
		only_if {File.exist?("/tmp/wp/wordpress/")}
	end
	e.run_action(:run)
	print "  *********************** updated package #{node['pkg-wp']['version']}\n"
end



