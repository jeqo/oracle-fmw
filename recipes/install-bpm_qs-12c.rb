include_recipe "oracle-fmw::prepare-environment-12c"

os_user = node['fmw-12c']['os_user']
os_installer_group = node['fmw-12c']['os_installer_group']

# Unzip installers
installer_zip = File.join(Chef::Config[:file_cache_path], "fmw_#{node['bpm_qs-12c']['version']}.0.0_bpmqs_Disk1_1of1.zip")
installer_jar_path = File.join(Chef::Config[:file_cache_path], "fmw_#{node['bpm_qs-12c']['version']}.0.0_bpm_quickstart.jar")

unzip_command = "unzip -o -d #{Chef::Config[:file_cache_path]} #{installer_zip}"

remote_file installer_zip do
	source node['bpm_qs-12c']['url']
	action :create
end

execute unzip_command do
	cwd Chef::Config[:file_cache_path]
	action :run
	creates installer_jar_path
end

# Create Response File
response_file = File.join(Chef::Config[:file_cache_path], "bpm_qs-12c.rsp")

template response_file do
	source "bpm_qs-12c.rsp.erb"
	variables({
		:oracle_home => node['fmw-12c']['home']
	})
end

# Install BPM QuickStart
install_command = "java -jar #{installer_jar_path} -silent -responseFile #{response_file} -invPtrLoc #{node['fmw-12c']['orainventory_file']}"

execute install_command do
	cwd Chef::Config[:file_cache_path]
	user os_user
	group os_installer_group
	action :run
	creates "#{node['fmw-12c']['home']}/oraInst.loc"
end
