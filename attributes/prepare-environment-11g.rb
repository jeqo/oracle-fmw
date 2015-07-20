default['fmw-11g']['os_user'] = "oracle"
default['fmw-11g']['os_installer_group'] = "oinstall"
default['fmw-11g']['os_timezone'] = "America/Lima"
default['fmw-11g']['orainventory_directory'] = "#{node['fmw-11g']['os_user_home']}/oraInventory"
default['fmw-11g']['orainventory_file'] = "#{node['fmw-11g']['orainventory_directory']}/ora_inventory.rsp"

default['fmw-11g']['home'] = "/u01/oracle/fmw/11g"

default['fmw-11g']['soft_nofile'] = "8182"
default['fmw-11g']['hard_nofile'] = "8182"

default['fmw-11g']['packages'] = [
  { "name" => "binutils", "arch" => "x86_64"	},
  { "name" => "compat-libcap1", "arch" => "x86_64"	},
  { "name" => "compat-libcap1", "arch" => "i686" 	},
  { "name" => "gcc", "arch" => "x86_64" 	},
  { "name" => "gcc-c++", "arch" => "x86_64" 	},
  { "name" => "glibc", "arch" => "i686" 	},
  { "name" => "glibc", "arch" => "x86_64" 	},
  { "name" => "glibc-devel", "arch" => "x86_64" 	},
  { "name" => "glibc-devel", "arch" => "i686" 	},
  { "name" => "ksh", "arch" => "x86_64" 	},
  { "name" => "libgcc", "arch" => "x86_64" 	},
  { "name" => "libgcc", "arch" => "i686" 	},
  { "name" => "compat-libstdc++-33", "arch" => "x86_64" 	},
  { "name" => "compat-libstdc++-33", "arch" => "i686" 	},
  { "name" => "libstdc++", "arch" => "x86_64" 	},
  { "name" => "libstdc++", "arch" => "i686" 	},
  { "name" => "libstdc++-devel", "arch" => "x86_64" 	},
  { "name" => "libstdc++-devel", "arch" => "i686" 	},
  { "name" => "libaio", "arch" => "x86_64" 	},
  { "name" => "libaio", "arch" => "i686" 	},
  { "name" => "elfutils-libelf-devel", "arch" => "x86_64" 	},
  { "name" => "elfutils-libelf-devel", "arch" => "i686" 	},
  { "name" => "libaio-devel", "arch" => "x86_64" 	},
  { "name" => "libaio-devel", "arch" => "i686" 	},
  { "name" => "libaio", "arch" => "x86_64" 	},
  { "name" => "libaio", "arch" => "i686" 	},
  { "name" => "libaio-devel", "arch" => "x86_64" 	},
  { "name" => "libaio-devel", "arch" => "i686" 	},
  { "name" => "make", "arch" => "x86_64" 	},
  { "name" => "sysstat", "arch" => "x86_64" 	}
]

override['java']['install_flavor'] = "oracle"
override['java']['jdk_version'] = "7"
override['java']['oracle']['accept_oracle_download_terms'] = true
