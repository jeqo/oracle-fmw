default['domain-12c']['name'] = "DefaultDomain"
default['domain-12c']['domains_path'] = "/home/oracle-fmw/work/domains"
default['domain-12c']['apps_path'] = "/home/oracle-fmw/work/apps"
# mode: Expanded or Compact
default['domain-12c']['mode'] = "Expanded"
# start_mode : dev or prod
default['domain-12c']['start_mode'] = "dev"
default['domain-12c']['crossdomain_enabled'] = true
default['domain-12c']['admin_username'] = "weblogic"
default['domain-12c']['admin_password'] = "welcome1"

default['domain-12c']['db_repo_host'] = "localhost"
default['domain-12c']['db_repo_port'] = "1521"
default['domain-12c']['db_repo_sid'] = "XE"
default['domain-12c']['db_repo_url'] = "jdbc:oracle:thin:@#{node['domain-12c']['db_repo_host']}:#{node['domain-12c']['db_repo_port']}:#{node['domain-12c']['db_repo_sid']}"
default['domain-12c']['db_repo_prefix'] = "DEV01"
default['domain-12c']['db_repo_password'] = "welcome1"

default['domain-12c']['apps'] = [
	#{"name" => "OSB", "enabled" => false},
	#{"name" => "SOA", "enabled" => false},
	#{"name" => "BPM", "enabled" => false},
	#{"name" => "BAM", "enabled" => false}
]

default['domain-12c']['machines'] = [
	#{
	#	"name" => "LocalMachine",
	#	"nm_address" => "localhost",
	#	"nm_port" => "5556"
	#}
]

default['domain-12c']['clusters'] = [
]

default['domain-12c']['admin_server'] = {
	"base_name" => "AdminServer",
	"new_name" => "admin_server",
	#"machine_name" => "LocalMachine",
	#"address" => "localhost",
	"port" => "7001"
}

default['domain-12c']['managed_servers'] = [
	#{
	#	"base_name" => "AdminServer",
	#	"new_name" => "AdminServer",
	#	"address" => "localhost",
	#	"port" => "7001"
	#	"machine" => "LocalMachine"
	#}
]
