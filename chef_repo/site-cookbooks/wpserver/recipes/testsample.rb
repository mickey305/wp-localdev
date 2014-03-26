
# test
script "create-sample1" do
	interpreter "bash"
	user "root"
	code <<-EOL
		touch /vagrant/sample.txt
	EOL
end
print "  ***************************** sample1 result -> "
puts File.exist?("/vagrant/sample.txt")

# test2
e = script "create-sample2" do
	action :nothing
	interpreter "bash"
	user "root"
	code <<-EOL
		touch /vagrant/sample2.txt
	EOL
end
e.run_action(:run)
print "  ***************************** sample2 result -> "
p File.exist?("/vagrant/sample2.txt")


