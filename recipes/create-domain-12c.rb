os_user = node['fmw-12c']['os_user']
os_installer_group = node['fmw-12c']['os_installer_group']

# Prepare Template
create_domain_py = File.join(Chef::Config[:file_cache_path], "new_domain-12c.py")
mw_home = node['fmw-12c']['home']
wl_home = "#{mw_home}/wlserver"
common_home = "#{mw_home}/oracle_common"
osb_home = "#{mw_home}/osb"
soa_home = "#{mw_home}/soa"

template create_domain_py do
	source "new_domain-12c.py.erb"
	variables({
		:domain_mode => node['domain-12c']['mode'],
		:domains_path => node['domain-12c']['domains_path'],
		:apps_path => node['domain-12c']['apps_path'],
		:domain => node['domain-12c']['name'],
		:start_mode => node['domain-12c']['start_mode'],
		:crossdomain_enabled => node['domain-12c']['crossdomain_enabled'],
		:username => node['domain-12c']['admin_username'],
		:password => node['domain-12c']['admin_password'],
		:db_url => node['domain-12c']['db_repo_url'],
		:db_schema_prefix => node['domain-12c']['db_repo_prefix'],
		:db_schema_password => node['domain-12c']['db_repo_password'],
		:wl_home => wl_home,
		:common_home => common_home,
		:osb_home => osb_home,
		:soa_home => soa_home,
		:machines => node['domain-12c']['machines'],
		:admin_server => node['domain-12c']['admin_server'],
		:managed_servers => node['domain-12c']['managed_servers'],
		:apps => node['domain-12c']['apps']
	})
end

# Create directories
directory node['domain-12c']['domains_path'] do
	owner os_user
	group os_installer_group
	recursive true
	action :create
end

directory node['domain-12c']['apps_path'] do
	owner os_user
	group os_installer_group
	recursive true
	action :create
end

# Run WLST script
wlst_exec = "#{wl_home}/common/bin/wlst.sh #{create_domain_py}"

ENV['ORACLE_HOME'] = mw_home
ENV['TZ'] = node['fmw-12c']['os_timezone']

execute wlst_exec do
	user os_user
	group os_installer_group
	action :run
	creates "#{node['domain-12c']['domains_path']}/#{node['domain-12c']['name']}/config/config.xml"
end
