include_recipe "oracle-fmw::install-wls-11g"

os_user = node['fmw-11g']['os_user']
os_group = node['fmw-11g']['os_installer_group']

# Get installer
installer_directory = "#{Chef::Config[:file_cache_path]}/soa-11g"

directory installer_directory do
	action :create
end

installer_zip_1 = File.join(installer_directory, node['soa-11g']['installer_file_1'])
installer_zip_2 = File.join(installer_directory, node['soa-11g']['installer_file_2'])

remote_file installer_zip_1 do
	source node['soa-11g']['url_1']
	checksum node['soa-11g']['checksum_1']
	action :create
end

remote_file installer_zip_2 do
	source node['soa-11g']['url_2']
	checksum node['soa-11g']['checksum_2']
	action :create
end

# Unzip installers
runInstaller = "#{installer_directory}/Disk1/runInstaller"

unzip1_command = "unzip -o #{installer_zip_1}"

execute unzip1_command do
	cwd "#{installer_directory}"
	action :run
  creates runInstaller
end

unzip2_command = "unzip -o #{installer_zip_2}"

execute unzip2_command do
	cwd "#{installer_directory}"
	action :run
  creates "#{installer_directory}/Disk4"
end

# Create Response File
oracle_soa_response = "#{installer_directory}/soa_install-11g.rsp"
mw_home = node['fmw-11g']['home']
soa_home = "#{node['fmw-11g']['home']}/#{node['soa-11g']['home_directory']}"

template oracle_soa_response do
	source "soa_install-11g.rsp.erb"
	variables({
		:middleware_home => mw_home,
		:oracle_soa_home => soa_home
	})
end

# Run Installer
java_home = node['java']['java_home']
install_command = "#{runInstaller} -jreLoc #{java_home} -silent -responseFile #{oracle_soa_response} -debug -waitforcompletion -invPtrLoc #{node['fmw-11g']['orainventory_file']}"
run_command = "su -l #{os_user} -c '#{install_command}'"

execute run_command do
	action :run
	creates soa_home
end
