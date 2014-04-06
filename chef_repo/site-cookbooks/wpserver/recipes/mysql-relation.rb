# make template directory
e = script "mkdir-#{node['wpserver']['tmp-file']['sql']['path']}" do
	interpreter "bash"
	user "root"
	action :nothing
	code <<-EOL
		mkdir #{node['wpserver']['tmp-file']['sql']['path']}
	EOL
	not_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}")}
end
e.run_action(:run)
# make grants.sql, set.sql and tables.sql
e = template "grants.sql" do
	path "#{node['wpserver']['tmp-file']['sql']['path']}grants.sql"
	source "grants.sql.erb"
	mode 0644
	action :nothing
	not_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}grants.sql")}
end
e.run_action(:create)
if node['mysql-conf']['reset-rootpass-flag'] then
	e = template "set.sql" do
		path "#{node['wpserver']['tmp-file']['sql']['path']}set.sql"
		source "set.sql.erb"
		mode 0644
		action :nothing
		not_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}set.sql")}
	end
	e.run_action(:create)
end
# e = template "tables.sql" do
# 	path "#{node['wpserver']['tmp-file']['sql']['path']}tables.sql"
# 	source "tables.sql.erb"
# 	mode 0644
# 	action :nothig
# 	not_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}tables.sql")}
# end
# e.run_action(:create)



if node['mysql-conf']['reset-rootpass-flag'] then
	# reset mysql rootpassword
	execute "mysql-set-rootpass" do
		command "mysql -u root --password=\"#{node['wpserver']['db']['old-rootpass']}\" < #{node['wpserver']['tmp-file']['sql']['path']}set.sql"
		action :nothing
	end
	template "#{node['wpserver']['tmp-file']['sql']['path']}set.sql" do
		owner "root"
		group "root"
		mode 0600
		variables :password => node['wpserver']['db']['rootpass']
		notifies :run, "execute[mysql-set-rootpass]", :immediately
	end
end
# create DB user
execute "mysql-create-user" do
	command "mysql -u root --password=\"#{node['wpserver']['db']['rootpass']}\" < #{node['wpserver']['tmp-file']['sql']['path']}grants.sql"
	action :nothing
end
template "#{node['wpserver']['tmp-file']['sql']['path']}grants.sql" do
	owner "root"
	group "root"
	mode 0600
	variables(
		:user     => node['wpserver']['db']['user'],
		:password => node['wpserver']['db']['pass'],
		:database => node['wpserver']['db']['database']
	)
	notifies :run, "execute[mysql-create-user]", :immediately
end
# create DB
# 
execute "mysql-create-database" do
	command "mysqladmin -u root create #{node['wpserver']['db']['database']}"
	not_if do
		require 'rubygems'
		Gem.clear_paths
		require 'mysql'
		msql = Mysql.new(node['wpserver']['db']['host'], "root", node['wpserver']['db']['rootpass'])
		msql.list_dbs.include?(node['wpserver']['db']['database'])
	end
end
# # create table
# execute "mysql-create-tables" do
# 	command "mysql -u root #{node['wpserver']['db']['database']} < #{node['wpserver']['tmp-file']['sql']['path']}tables.sql"
# 	action :nothing
# 	only_if do
# 		require 'rubygems'
# 		Gem.clear_paths
# 		require 'mysql'
# 		msql = Mysql.new(node['wpserver']['db']['host'], "root", node['wpserver']['db']['rootpass'])
# 		begin
# 			msql.select_db(node['wpserver']['db']['database'])
# 			msql.list_tables.empty?
# 		rescue Mysql::Error
# 			return false
# 		end
# 	end
# end
# template "#{node['wpserver']['tmp-file']['sql']['path']}tables.sql" do
# 	owner "root"
# 	group "root"
# 	mode 0600
# 	notifies :run, "execute[mysql-create-tables]", :immediately
# end

# delete grants.sql and set.sql files
script "delete-#{node['wpserver']['tmp-file']['sql']['path']}grants.sql" do
	interpreter "bash"
	user "root"
	code "rm -f #{node['wpserver']['tmp-file']['sql']['path']}grants.sql"
	action :nothing
	subscribes :run, "execute[mysql-create-user]", :immediately
	only_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}grants.sql")}
end
script "delete-#{node['wpserver']['tmp-file']['sql']['path']}set.sql" do
	interpreter "bash"
	user "root"
	code "rm -f #{node['wpserver']['tmp-file']['sql']['path']}set.sql"
	action :nothing
	subscribes :run, "execute[mysql-set-rootpass]", :immediately
	only_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}set.sql")}
end

# # delete tables.sql file
# execute "delete-#{node['wpserver']['tmp-file']['sql']['path']}tables.sql" do
# 	command "/bin/rm -f #{node['wpserver']['tmp-file']['sql']['path']}tables.sql"
# 	action :nothing
# 	only_if {File.exist?("#{node['wpserver']['tmp-file']['sql']['path']}tables.sql")}
# 	subscribes :run, "execute[mysql-create-tables]", :immediately
# end



if node['mysql-conf']['create-setting-mysqlbackup-flag'] then
	# back up mySQL DB
	#
	if !File.exist?("/root/backup/") then
		e = script "mkdir-/root/backup/" do
			interpreter "bash"
			user "root"
			action :nothing
			code "mkdir /root/backup/"
		end
		e.run_action(:run)
	end
	if !File.exist?("/root/backup/mysql/") then
		e = script "mkdir-/root/backup/mysql/" do
			interpreter "bash"
			user "root"
			action :nothing
			code "mkdir /root/backup/mysql"
		end
		e.run_action(:run)
	end
	# initialize setting files
	e = execute "delete-/etc/cron.d/backup_mysql" do
		command "rm -f /etc/cron.d/backup_mysql"
		action :nothing
		only_if {File.exist?("/etc/cron.d/backup_mysql")}
	end
	e.run_action(:run)
	e = execute "delete-/root/backup_mysql.sh" do
		command "rm -f /root/backup_mysql.sh"
		action :nothing
		only_if {File.exist?("/root/backup_mysql.sh")}
	end
	e.run_action(:run)



	# insert backup setting files
	e = template "backup_mysql.sh" do
		path "/root/backup_mysql.sh"
		source "backup_mysql.sh.erb"
		mode 0700
		action :nothing
		variables(
			:days     => node['wpserver']['db']['store-days'],
			:password => node['wpserver']['db']['rootpass']
		)
		not_if {File.exist?("/root/backup_mysql.sh")}
	end
	e.run_action(:create)
	
	# シェルスクリプトを実行させる頻度を設定
	if !File.exist?("/etc/cron.d/backup_mysql") then
		e = script "write /etc/cron.d" do
			interpreter "bash"
			user "root"
			action :nothing
			code <<-EOL
				echo "5 */3 * * * root /root/backup_mysql.sh" > /etc/cron.d/backup_mysql
				# echo "*/5 * * * * root /root/backup_mysql.sh" > /etc/cron.d/backup_mysql
			EOL
			only_if {File.exist?("/root/backup_mysql.sh")}
		end
		e.run_action(:run)
	end

end
