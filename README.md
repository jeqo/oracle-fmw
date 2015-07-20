**oracle-fmw** Cookbook
===================
This cookbook lets you install and configure Oracle Fusion Middleware.

Support SOA and BPM 12c Quickstart distributions, and SOA and BPM Suite 11g.

Requirements
------------
### packages
- `java` - oracle-fmw use *java* cookbook to install JDK 6/7
- `oracle-xe` - oracle-fmw recommend to use *oracle-xe* to install Oracle XE and create a database instance

### operating systems
- `oracle-fmw` is tested to be used on Oracle Linux, Red Hat and Centos related distributions.

Attributes
----------

### 11g version

#### oracle-fmw::prepare-environment-11g

Creates an OS user and group to run commands and install software.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['fmw-11g']['os_user']</tt></td>
    <td>String</td>
    <td>OS user</td>
    <td><tt>oracle-fmw</tt> <br/> (*oracle* is not recommended if your are using *oracle-xe* cookbook before using *oracle-fmw*)</td>
  </tr>
  <tr>
    <td><tt>['fmw-11g']['os_installer_group']</tt></td>
    <td>String</td>
    <td>OS group</td>
    <td><tt>oinstall</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-11g']['os_timezone']</tt></td>
    <td>String</td>
    <td>OS Timezone. Used to avoid JDBC issue.</td>
    <td><tt>America/Lima</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-11g']['home']</tt></td>
    <td>String</td>
    <td>OS user home</td>
    <td><tt>/home/#{node['fmw-11g']['os_user']}</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-11g']['home']</tt></td>
    <td>String</td>
    <td>Middleware Home</td>      <td><tt>#{node['fmw-11g']['os_user_home']}/fmw/bpm_qs/#{node['fmw-11g']['version']}</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::install-wls-11g

Installs [Oracle WebLogic Server 11g](http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-main-097127.html).


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['wls-11g']['home_directory']</tt></td>
    <td>String</td>
    <td>Name of WLS directory on Middleware Home</td>
    <td><tt>wlserver_10.</tt></td>
  </tr>
  <tr>
    <td><tt>['wls-11g']['url']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/wls-11g/wls1036_generic.jar</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::install-soa-11g

Installs [Oracle SOA Suite 11g](http://www.oracle.com/technetwork/middleware/soasuite/downloads/soasuite11gdownload-2210918.html).


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['soa-11g']['home_directory']</tt></td>
    <td>String</td>
    <td>Name of SOA directory on Middleware Home</td>
    <td><tt>OracleSOA1</tt></td>
  </tr>
  <tr>
    <td><tt>['soa-11g']['url_1']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/soa-11g/ofm_soa_generic_11.1.1.7.0_disk1_1of2.zip</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['soa-11g']['url_2']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/soa-11g/ofm_soa_generic_11.1.1.7.0_disk1_2of2.zip</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::install-osb-11g

Installs [Oracle OSB Suite 11g](http://www.oracle.com/technetwork/middleware/service-bus/downloads/index.html).


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['osb-11g']['home_directory']</tt></td>
    <td>String</td>
    <td>Name of SOA directory on Middleware Home</td>
    <td><tt>OracleOSB1</tt></td>
  </tr>
  <tr>
    <td><tt>['osb-11g']['url']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/osb-11g/ofm_osb_generic_11.1.1.7.0_disk1_1of1.zip</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::create-rcu_repository-11g

Creates RCU repositories with Middleware required schemas.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>['rcu-11g']['url']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/rcu-11g/ofm_rcu_linux_11.1.1.7.0_32_disk1_1of1.zip</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_hostname']</tt></td>
    <td>String</td>
    <td>Database hostname or IP</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_port']</tt></td>
    <td>String</td>
    <td>Database listener port</td>
    <td><tt>1521</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_service']</tt></td>
    <td>String</td>
    <td>Database service name</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_dba_role']</tt></td>
    <td>String</td>
    <td>Database DBA role name</td>
    <td><tt>sysdba</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_dba_user']</tt></td>
    <td>String</td>
    <td>Database DBA username</td>
    <td><tt>sys</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_dba_password']</tt></td>
    <td>String</td>
    <td>Database  DBA user password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_schemas_password']</tt></td>
    <td>String</td>
    <td>Password used by new schemas</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['db_schema_prefix']</tt></td>
    <td>String</td>
    <td>Prefix used by new schemas</td>
    <td><tt>DEV01</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['components']</tt></td>
    <td>Array[String]</td>
    <td>Components to create a schema for</td>
    <td><tt>[
    #"SOAINFRA",
    #"MDS",
    #"ORASDPM"
    ]</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-11g']['keep_existing_schema']</tt></td>
    <td>String</td>
    <td>Avoid recreating schemas if your are running provisioning several times</td>
    <td><tt>true</tt></td>
  </tr>
</table>


#### oracle-fmw::create-domain-11g

Creates a new domain.


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['domain-11g']['name']</tt></td>
    <td>String</td>
    <td>Domain name</td>
    <td><tt>DefaultDomain</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['domains_path']</tt></td>
    <td>String</td>
    <td>Domains directory</td>
    <td><tt>/home/oracle-fmw/work/domains</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['apps_path']</tt></td>
    <td>String</td>
    <td>Applications directory</td>
    <td><tt>/home/oracle-fmw/work/apps</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['start_mode']</tt></td>
    <td>String</td>
    <td>Domain start mode: dev or prod</td>
    <td><tt>dev</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['admin_username']</tt></td>
    <td>String</td>
    <td>Domain admin username</td>
    <td><tt>weblogic</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['admin_password']</tt></td>
    <td>String</td>
    <td>Domain admin password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['db_repo_host']</tt></td>
    <td>String</td>
    <td>Database repository hostname or ip</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['db_repo_port']</tt></td>
    <td>String</td>
    <td>Database repository listener port</td>
    <td><tt>1521</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['db_repo_sid']</tt></td>
    <td>String</td>
    <td>Database repository service name</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['db_repo_prefix']</tt></td>
    <td>String</td>
    <td>Database schemas prefix</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['db_repo_password']</tt></td>
    <td>String</td>
    <td>Database schemas password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-11g']['apps']</tt></td>
    <td>Array[App]</td>
    <td>Applications to add to domain: SOA, BPM, BAM, OSB. Attributes: name (String), enabled (Boolean)</td>
    <td><tt>[
    {"name" : "SOA", "enabled" : true},
    {"name" : "SOA_DEV", "enabled" : true},
    {"name" : "BAM", "enabled" : true},
    {"name" : "EM", "enabled" : true},
    {"name" : "OSB", "enabled" : false},
    {"name" : "OSB_DEV", "enabled" : false}
    ]</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['machines']</tt></td>
    <td>Array[Machine]</td>
    <td>WebLogic Machines: name, nm_address, nm_port</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['admin_server']</tt></td>
    <td>Server</td>
    <td>WebLogic Server</td>
    <td><tt>{"base_name" : "AdminServer",
    "new_name" : "bpm_bpm-server",
    "port" : "7001"}</tt></td>
  </tr>  
  <tr>
    <td><tt>['domain-12c']['managed_servers']</tt></td>
    <td>Array[Server]</td>
    <td>WebLogic Managed Servers.</td>
    <td><tt>[]</tt></td>
  </tr>
</table>


### 12c version

#### oracle-fmw::prepare-environment-12c

Creates an OS user and group to run commands and install software.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['fmw-12c']['os_user']</tt></td>
    <td>String</td>
    <td>OS user</td>
    <td><tt>oracle-fmw</tt> <br/> (*oracle* is not recommended if your are using *oracle-xe* cookbook before using *oracle-fmw*)</td>
  </tr>
  <tr>
    <td><tt>['fmw-12c']['os_installer_group']</tt></td>
    <td>String</td>
    <td>OS group</td>
    <td><tt>oinstall</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-12c']['os_timezone']</tt></td>
    <td>String</td>
    <td>OS Timezone. Used to avoid JDBC issue.</td>
    <td><tt>America/Lima</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-12c']['home']</tt></td>
    <td>String</td>
    <td>OS user home</td>
    <td><tt>/home/#{node['fmw-12c']['os_user']}</tt> <br/></td>
  </tr>
  <tr>
    <td><tt>['fmw-12c']['home']</tt></td>
    <td>String</td>
    <td>Middleware Home</td>      <td><tt>#{node['fmw-12c']['os_user_home']}/fmw/bpm_qs/#{node['fmw-12c']['version']}</tt> <br/></td>
  </tr>
</table>


#### oracle-fmw::install-bpm_qs-12c

Installs [Oracle BPM 12c Quickstart](http://www.oracle.com/technetwork/middleware/bpm/downloads/index.html).


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bpm_qs-12c']['version']</tt></td>
    <td>String</td>
    <td>Product version</td>
    <td><tt>12.1.3</tt></td>
  </tr>
  <tr>
    <td><tt>['bpm_qs-12c']['url']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/bpm_qs-12c/fmw_#{node['bpm_qs-12c']['version']}.0.0_bpmqs_Disk1_1of1.zip</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::install-soa_qs-12c

Installs [Oracle SOA 12c Quickstart](http://www.oracle.com/technetwork/middleware/soa/downloads/index.html).


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['soa_qs-12c']['version']</tt></td>
    <td>String</td>
    <td>Product version</td>
    <td><tt>12.1.3</tt></td>
  </tr>
  <tr>
    <td><tt>['soa_qs-12c']['url']</tt></td>
    <td>String</td>
    <td>URL to download the installer. Could be http:// ftp:// or file://</td>  <td><tt>file:///data/oracle-fmw/soa_qs-12c/fmw_#{node['soa_qs-12c']['version']}.0.0_soaqs_Disk1_1of1.zip</tt> <br/></td>
  </tr>
</table>

#### oracle-fmw::create-rcu_repository-12c

Creates RCU repositories with Middleware required schemas.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
    <tr>
    <td><tt>['rcu-12c']['oracle_home']</tt></td>
    <td>String</td>
    <td>Oracle Home directory</td>
    <td><tt>/home/oracle-fmw/fmw/bpm_qs/12c</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['timezone']</tt></td>
    <td>String</td>
    <td>OS timezone</td>
    <td><tt>America/Lima</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_hostname']</tt></td>
    <td>String</td>
    <td>Database hostname or IP</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_port']</tt></td>
    <td>String</td>
    <td>Database listener port</td>
    <td><tt>1521</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_service']</tt></td>
    <td>String</td>
    <td>Database service name</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_dba_role']</tt></td>
    <td>String</td>
    <td>Database DBA role name</td>
    <td><tt>sysdba</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_dba_user']</tt></td>
    <td>String</td>
    <td>Database DBA username</td>
    <td><tt>sys</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_dba_password']</tt></td>
    <td>String</td>
    <td>Database  DBA user password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_schemas_password']</tt></td>
    <td>String</td>
    <td>Password used by new schemas</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['db_schema_prefix']</tt></td>
    <td>String</td>
    <td>Prefix used by new schemas</td>
    <td><tt>DEV01</tt></td>
  </tr>
  <tr>
    <td><tt>['rcu-12c']['components']</tt></td>
    <td>Array[String]</td>
    <td>Components to create a schema for</td>
    <td><tt>[
    "SOAINFRA",
    "OPSS",
    "IAU",
    "MDS",
    "WLS",
    "UCSUMS",
    "IAU_APPEND",
    "IAU_VIEWER"
    ]</tt></td>
  </tr>
</table>


#### oracle-fmw::create-domain-12c

Creates a new domain.


<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['domain-12c']['name']</tt></td>
    <td>String</td>
    <td>Domain name</td>
    <td><tt>DefaultDomain</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['domains_path']</tt></td>
    <td>String</td>
    <td>Domains directory</td>
    <td><tt>/home/oracle-fmw/work/domains</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['apps_path']</tt></td>
    <td>String</td>
    <td>Applications directory</td>
    <td><tt>/home/oracle-fmw/work/apps</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['mode']</tt></td>
    <td>String</td>
    <td>Domain mode: Expanded or Compact</td>
    <td><tt>Expanded</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['start_mode']</tt></td>
    <td>String</td>
    <td>Domain start mode: dev or prod</td>
    <td><tt>dev</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['admin_username']</tt></td>
    <td>String</td>
    <td>Domain admin username</td>
    <td><tt>weblogic</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['admin_password']</tt></td>
    <td>String</td>
    <td>Domain admin password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['db_repo_host']</tt></td>
    <td>String</td>
    <td>Database repository hostname or ip</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['db_repo_port']</tt></td>
    <td>String</td>
    <td>Database repository listener port</td>
    <td><tt>1521</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['db_repo_sid']</tt></td>
    <td>String</td>
    <td>Database repository service name</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['db_repo_prefix']</tt></td>
    <td>String</td>
    <td>Database schemas prefix</td>
    <td><tt>XE</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['db_repo_password']</tt></td>
    <td>String</td>
    <td>Database schemas password</td>
    <td><tt>welcome1</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['apps']</tt></td>
    <td>Array[App]</td>
    <td>Applications to add to domain: SOA, BPM, BAM, OSB. Attributes: name (String), enabled (Boolean)</td>
    <td><tt>[
    {"name" : "SOA", "enabled" : true},
    {"name" : "BPM", "enabled" : true},
    {"name" : "BAM", "enabled" : true},
    {"name" : "OSB", "enabled" : false}
    ]</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['machines']</tt></td>
    <td>Array[Machine]</td>
    <td>WebLogic Machines: name, nm_address, nm_port</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['domain-12c']['admin_server']</tt></td>
    <td>Server</td>
    <td>WebLogic Server</td>
    <td><tt>{"base_name" : "AdminServer",
    "new_name" : "bpm_bpm-server",
    "port" : "7001"}</tt></td>
  </tr>  
  <tr>
    <td><tt>['domain-12c']['managed_servers']</tt></td>
    <td>Array[Server]</td>
    <td>WebLogic Managed Servers.</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

Usage
-----

Example to install Oracle BPM 12c and create a domain with SOA/BPM/BAM.

```json
{
  "name" : "demo-bpm_bam-12c",
  "default_attributes" : {
    "domain-12c": {
      "name": "demo-bpm_bam-domain",
      "mode": "Compact",
      "apps": [
        {"name" : "SOA", "enabled" : true},
        {"name" : "BPM", "enabled" : true},
        {"name" : "BAM", "enabled" : true},
        {"name" : "OSB", "enabled" : false}
      ],
      "machines": [
      ],
      "admin_server": {
        "base_name" : "AdminServer",
        "new_name" : "bpm_bpm-server",
        "port" : "7001"
      },
      "managed_servers": [
      ],
      "db_repo_host": "localhost",
      "db_repo_port": "1521",
      "db_repo_sid": "xe",
      "db_repo_prefix": "DEMO",
      "db_repo_password": "welcome1"
    },
    "rcu-12c": {
      "db_schema_prefix": "DEMO",
      "db_dba_user": "SYS",
      "db_dba_role": "SYSDBA",
      "db_dba_password": "welcome1",
      "db_schemas_password": "welcome1",
      "db_hostname": "localhost",
      "db_port": "1521",
      "db_service": "xe",
      "components": [
        "SOAINFRA",
        "OPSS",
        "IAU",
        "MDS",
        "WLS",
        "UCSUMS",
        "IAU_APPEND",
        "IAU_VIEWER"
      ]
    }
  },
  "run_list" : [
  "recipe[oracle-fmw::install-bpm_qs-12c]",
  "recipe[oracle-fmw::create-rcu_repository-12c]",
  "recipe[oracle-fmw::create-domain-12c]"
  ]
}

```

More samples on [chef-repo](https://github.com/jeqo/chef-repo/tree/master/roles)

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: [Jorge Quilcate](http://jeqo.github.io) [(quilcate.jorge@gmail.com)](mailto:quilcate.jorge@gmail.com)
