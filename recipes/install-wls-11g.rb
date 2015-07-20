include_recipe "oracle-fmw::prepare-environment-11g"

os_user = node['fmw-11g']['os_user']
os_group = node['fmw-11g']['os_installer_group']

# Getting the installer
installer_jar = File.join(Chef::Config[:file_cache_path], node['wls-11g']['installer_file'])

remote_file installer_jar do
	source node['wls-11g']['url']
	checksum node['wls-11g']['checksum']
	action :create
end


# Define Response File
response_file = File.join(Chef::Config[:file_cache_path], "install_wls-11g.rsp")
mw_home = "#{node['fmw-11g']['home']}"
wls_home = "#{node['fmw-11g']['home']}/#{node['wls-11g']['home_directory']}"

template response_file do
  source "install_wls-11g.rsp.erb"
  variables({
    :mw_home 	=> "#{mw_home}",
    :wls_home 	=> "#{wls_home}"
    })
end

# Run Installer
install_command = "java -jar #{installer_jar} -mode=silent -silent_xml=#{response_file}"

execute install_command do
  action :run
  user os_user
  group os_group
  not_if do
    FileTest.directory?(wls_home)
  end
end
