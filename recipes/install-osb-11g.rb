include_recipe "oracle-fmw::install-wls-11g"

os_user = node['fmw-11g']['os_user']
os_group = node['fmw-11g']['os_installer_group']

# Get installer
installer_directory = "#{Chef::Config[:file_cache_path]}/osb-11g"

directory installer_directory do
	action :create
end

installer_zip = File.join(installer_directory, node['osb-11g']['installer_file'])

remote_file installer_zip do
	source node['osb-11g']['url']
	checksum node['osb-11g']['checksum']
	action :create
end


# Unzip installers
unzip_command = "unzip -o #{installer_zip}"
runInstaller = "#{installer_directory}/Disk1/runInstaller"

execute unzip_command do
	cwd "#{installer_directory}"
  action :run
  creates runInstaller
end

# Create Response File
oracle_osb_response = File.join(installer_directory, "osb_install-11g.rsp")
osb_installation_option = node['osb-11g']['installation_option']
mw_home = node['fmw-11g']['home']
osb_home = "#{node['fmw-11g']['home']}/#{node['osb-11g']['home_directory']}"
wl_home = "#{node['fmw-11g']['home']}/#{node['wls-11g']['home_directory']}"
oepe_home = node['osb-11g']['oepe_home']

case osb_installation_option
when "TYPICAL"
  template oracle_osb_response do
    source "osb_typical_install-11g.rsp.erb"
    variables({
      :middleware_home => mw_home,
      :oracle_home => osb_home,
      :wl_home => wl_home
      })
    end
when "CUSTOM"
  template oracle_osb_response do
    source "osb_custom_install-11g.rsp.erb"
    variables({
      :middleware_home => mw_home,
      :oracle_home => osb_home,
      :wl_home => wl_home,
      :oepe_home => oepe_home
      })
  end
else
end

# Run Installer
java_home = node['java']['java_home']
install_command = "#{runInstaller} -jreLoc #{java_home} -silent -responseFile #{oracle_osb_response} -debug -waitforcompletion -invPtrLoc #{node['fmw-11g']['orainventory_file']}"

execute install_command do
  action :run
  user os_user
  group os_group
  not_if do
    FileTest.directory?(osb_home)
  end
end
