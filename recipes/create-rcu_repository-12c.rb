# Create Password File
password_file = File.join(Chef::Config[:file_cache_path], "rcu-password_file-12c.txt")

template password_file do
	source "rcu-password_file-12c.txt.erb"
	variables({
		:sys_password => node['rcu-12c']['db_dba_password'],
		:schemas_password => node['rcu-12c']['db_schemas_password'],
		:components => node['rcu-12c']['components']
	})
end

# Run Wizard
ENV['ORACLE_HOME'] = node['rcu-12c']['oracle_home']
ENV['TZ'] = node['rcu-12c']['timezone']

components = ""
node['rcu-12c']['components'].each do |component|
	components = "-component #{component} #{components}"
end

rcu_remove_command = "#{node['rcu-12c']['oracle_home']}/oracle_common/bin/rcu -silent -dropRepository -databaseType ORACLE -connectString #{node['rcu-12c']['db_hostname']}:#{node['rcu-12c']['db_port']}:#{node['rcu-12c']['db_service']} -dbUser #{node['rcu-12c']['db_dba_user']} -dbRole #{node['rcu-12c']['db_dba_role']} -schemaPrefix #{node['rcu-12c']['db_schema_prefix']} #{components} -f < #{password_file}"

execute rcu_remove_command do
	action :run
	returns [0,1]
end

rcu_create_command = "#{node['rcu-12c']['oracle_home']}/oracle_common/bin/rcu -silent -createRepository -databaseType ORACLE -connectString #{node['rcu-12c']['db_hostname']}:#{node['rcu-12c']['db_port']}:#{node['rcu-12c']['db_service']} -dbUser #{node['rcu-12c']['db_dba_user']} -dbRole #{node['rcu-12c']['db_dba_role']} -schemaPrefix #{node['rcu-12c']['db_schema_prefix']} #{components} -f < #{password_file}"

execute rcu_create_command do
	action :run
end

# Remove Password File
template password_file do
	action :delete
end
