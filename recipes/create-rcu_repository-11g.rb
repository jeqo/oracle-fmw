# Get installer
installer_zip = File.join(Chef::Config[:file_cache_path], node['rcu-11g']['installer_zip'])

remote_file installer_zip do
	source node['rcu-11g']['url']
	checksum node['rcu-11g']['checksum']
	action :create
end

# Unzip wizard
rcu = "#{Chef::Config[:file_cache_path]}/rcuHome/bin/rcu"
unzip_command = "unzip -o #{installer_zip}"

execute unzip_command do
  cwd Chef::Config[:file_cache_path]
  action :run
  creates rcu
end

# Create Password File
password_file = File.join(Chef::Config[:file_cache_path], "rcu_password_file-11g.txt")

template password_file do
  source "rcu_password_file-11g.txt.erb"
  variables({
    :sys_password => node['rcu-11g']['db_dba_password'],
    :schemas_password => node['rcu-11g']['db_schemas_password'],
    :components => node['rcu-11g']['components']
  })
end

# Run Wizard
connectString = "#{node['rcu-11g']['db_hostname']}:#{node['rcu-11g']['db_port']}:#{node['rcu-11g']['db_service']}"

components = ""
node['rcu-11g']['components'].each do |component|
  components = "-component #{component} #{components}"
end

rcu_remove_command = "#{rcu} -silent -dropRepository -databaseType ORACLE -connectString #{connectString} -dbUser #{node['rcu-11g']['db_dba_user']} -dbRole #{node['rcu-11g']['db_dba_role']} -schemaPrefix #{node['rcu-11g']['db_schema_prefix']} #{components} -f < #{password_file}"

execute rcu_remove_command do
  action :run
  # 1 is included to pass when schemas don't exist
  returns [0,1]
  not_if {
    node['rcu-11g']['keep_existing_schema'] == true
  }
end

rcu_create_command = "#{rcu} -silent -createRepository -databaseType ORACLE -connectString #{connectString} -dbUser #{node['rcu-11g']['db_dba_user']} -dbRole #{node['rcu-11g']['db_dba_role']} -schemaPrefix #{node['rcu-11g']['db_schema_prefix']} #{components} -f < #{password_file}"

if node['rcu-11g']['keep_existing_schema'] == true
  create_returns = [0,1]
else
  create_returns = [0]
end

execute rcu_create_command do
  action :run
  returns create_returns
end

# Remove Password File
template password_file do
  action :delete
end
