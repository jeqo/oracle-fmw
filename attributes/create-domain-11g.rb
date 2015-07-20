default['domain-11g']['name'] = "DefaultDomain"
default['domain-11g']['domains_path'] = "/u01/oracle/work/domains"
default['domain-11g']['apps_path'] = "/u01/oracle/work/apps"
# start_mode : dev or prod
default['domain-11g']['start_mode'] = "dev"
default['domain-11g']['crossdomain_enabled'] = true
default['domain-11g']['admin_username'] = "weblogic"
default['domain-11g']['admin_password'] = "welcome1"

default['domain-11g']['db_repo_host'] = "192.168.56.10"
default['domain-11g']['db_repo_port'] = "1521"
default['domain-11g']['db_repo_sid'] = "xe"
default['domain-11g']['db_repo_url'] = "jdbc:oracle:thin:@#{node['domain-11g']['db_repo_host']}:#{node['domain-11g']['db_repo_port']}:#{node['domain-11g']['db_repo_sid']}"
default['domain-11g']['db_repo_prefix'] = "DEV01"
default['domain-11g']['db_repo_password'] = "welcome1"

default['domain-11g']['apps'] = [
	#{"name" => "SOA", "enabled" => false},
	#{"name" => "SOA_DEV", "enabled" => true},
	#{"name" => "BPM", "enabled" => false},
	#{"name" => "BPM_DEV", "enabled" => true},
	#{"name" => "OSB", "enabled" => false},
	#{"name" => "OSB_DEV", "enabled" => true},
	#{"name" => "BAM", "enabled" => false},
	#{"name" => "EM", "enabled" => false}
]

default['domain-11g']['machines'] = [
	#{
	#	"name" => "LocalMachine",
	#	"nm_address" => "192.168.56.10",
	#	"nm_port" => "5556"
	#}
]

default['domain-11g']['clusters'] = [
]

default['domain-11g']['admin_server'] = {
	#"base_name" => "AdminServer",
	#"new_name" => "admin_server",
	#"machine_name" => "LocalMachine",
	#"address" => "192.168.56.10",
	#"port" => "7001"
}

default['domain-11g']['managed_servers'] = [
	#{
	#	"base_name" => "AdminServer",
	#	"new_name" => "AdminServer",
	#	"address" => "localhost",
	#	"port" => "7001"
	#	"machine" => "LocalMachine"
	#}
]
