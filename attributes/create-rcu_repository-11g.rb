# default['rcu-11g']['rcu_wizard_zip'] = "#{node['rcu-11g']['root_directory']}/ofm_rcu_linux_11.1.1.7.0_64_disk1_1of1.zip"
default['rcu-11g']['url'] = "" #"file:///data/oracle-fmw/rcu-11g/ofm_rcu_linux_11.1.1.7.0_32_disk1_1of1.zip
default['rcu-11g']['installer_zip'] = "ofm_rcu_linux_11.1.1.7.0_32_disk1_1of1.zip"
default['rcu-11g']['checksum'] = "5ec50177acffed29b4d5daf71d92daf07198d6e479004ab8ec79b1e37962d0a8"

default['rcu-11g']['db_hostname'] = 'localhost'
default['rcu-11g']['db_port'] = '1521'
default['rcu-11g']['db_service'] = 'xe'
default['rcu-11g']['db_dba_role'] = 'sysdba'
default['rcu-11g']['db_dba_user'] = 'sys'
default['rcu-11g']['db_dba_password'] = 'welcome1'
default['rcu-11g']['db_schemas_password'] = 'welcome1'
default['rcu-11g']['db_schema_prefix'] = 'DEV01'
default['rcu-11g']['components'] = [
  #"SOAINFRA",
  #"MDS",
  #"ORASDPM"
]
default['rcu-11g']['keep_existing_schema'] = true
