include_recipe "java"

# User and group creation
os_user = node['fmw-11g']['os_user']
os_installer_group = node['fmw-11g']['os_installer_group']

group os_installer_group do
  action :create
  append true
end

os_user_home = "/home/#{node['fmw-11g']['os_user']}"

user os_user do
  supports :manage_home => true
  comment "Oracle user"
  gid os_installer_group
  home os_user_home
  shell "/bin/bash"
  password "$1$rUhN5PYi$2rQAEEuOBScZOKsMRpHDe0"
end

# Increase user limits
soft_limits = "#{os_user}	soft    nofile    #{node['fmw-11g']['soft_nofile']}"
hard_limits = "#{os_user}	hard    nofile    #{node['fmw-11g']['hard_nofile']}"
limits_file = "/etc/security/limits.conf"

bash "increase_limits" do
  user 'root'

  code <<-END.gsub(/^    /, '')
  echo soft_limits  >> limits_file
  echo hard_limits >> limits_file
  END

  not_if do
    file = ::File.read(limits_file)
    file.include?(soft_limits) \
    && \
    file.include?(hard_limits)
  end
end

reset_command = "ulimit -a"
run_reset = "su -l #{os_user} -c '#{reset_command}'"

execute run_reset do
  action :run
end

# Install packages
node['fmw-11g']['packages'].each do |package|
  package_title = "#{package['name']}.#{package['arch']}"

  yum_package package_title do
  end
end

# Create FMW Directories
directory node['fmw-11g']['home'] do
  owner os_user
  group os_installer_group
  recursive true
  action :create
end

# Create OraInventory template
ora_inventory_directory = "#{node['fmw-11g']['orainventory_directory']}"
ora_inventory_file = "#{node['fmw-11g']['orainventory_file']}"

directory ora_inventory_directory do
  owner os_user
  group os_installer_group
  recursive true
  action :create
end

template ora_inventory_file do
  source "ora_inventory-11g.rsp.erb"
  owner os_user
  group os_installer_group
  variables({
    :ora_inventory_directory => ora_inventory_directory,
    :install_group => os_installer_group
  })
end
