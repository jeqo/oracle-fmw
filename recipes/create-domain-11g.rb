include_recipe "oracle-fmw::prepare-environment-11g"

os_user = node['fmw-11g']['os_user']
os_group = node['fmw-11g']['os_installer_group']

# Prepare Template
create_domain_py = "#{Chef::Config[:file_cache_path]}/create_domain.py"

wl_home = "#{node['fmw-11g']['home']}/#{node['wls-11g']['home_directory']}"
common_home = "#{node['fmw-11g']['home']}/oracle_common"
osb_home = "#{node['fmw-11g']['home']}/#{node['osb-11g']['home_directory']}"
soa_home = "#{node['fmw-11g']['home']}/#{node['soa-11g']['home_directory']}"
java_home = node['java']['java_home']

template create_domain_py do
	source "domain-11g.py.erb"
	variables({
		:java_home => java_home,
		:domains_path => node['domain-11g']['domains_path'],
		:apps_path => node['domain-11g']['apps_path'],
		:domain => node['domain-11g']['name'],
		:start_mode => node['domain-11g']['start_mode'],
		:crossdomain_enabled => node['domain-11g']['crossdomain_enabled'],
		:username => node['domain-11g']['admin_username'],
		:password => node['domain-11g']['admin_password'],
		:db_url => node['domain-11g']['db_repo_url'],
		:db_schema_prefix => node['domain-11g']['db_repo_prefix'],
		:db_schema_password => node['domain-11g']['db_repo_password'],
		:wl_home => wl_home,
		:common_home => common_home,
		:osb_home => osb_home,
		:soa_home => soa_home,
		:machines => node['domain-11g']['machines'],
		:admin_server => node['domain-11g']['admin_server'],
		:managed_servers => node['domain-11g']['managed_servers'],
		:apps => node['domain-11g']['apps']
	})
end

# Create directories
directory node['domain-11g']['domains_path'] do
	owner os_user
	group os_group
	recursive true
	action :create
end

directory node['domain-11g']['apps_path'] do
	owner os_user
	group os_group
	recursive true
	action :create
end

# Run WLST scripts
domain_home = "#{node['domain-11g']['domains_path']}/#{node['domain-11g']['name']}"

domain_config_file = "#{domain_home}/config/config.xml"
wlst_exec = "#{wl_home}/common/bin/wlst.sh #{create_domain_py}"

execute wlst_exec do
	creates domain_config_file
	user os_user
	group os_group
	action :run
end

# Upstart script
start_nm_script = "/etc/init/nodemanager.conf"

template start_nm_script do
	source "start-node_manager-11g.sh.erb"
	variables({
		:os_user => os_user,
		:wls_home => wl_home
	})
end

start_admin_server_script = "/etc/init/#{node['domain-11g']['name']}-admin_server.conf"

template start_admin_server_script do
	source "start-admin_server-11g.sh.erb"
	variables({
		:os_user => os_user,
		:domain_home => domain_home
	})
end

# Node Manager Properties file
nm_props = "#{wl_home}/common/nodemanager/nodemanager.properties"

template nm_props do
	source "node_manager-11g.properties.erb"
	variables({
		:wls_home => wl_home,
		:java_home => java_home
	})
end

# Fix Start Admin Server - Debug option
start_wls = "#{domain_home}/startWebLogic.sh"

template start_wls do
	source "startWebLogic-11g.sh.erb"
	variables({
		:domain_home => domain_home
	})
end
