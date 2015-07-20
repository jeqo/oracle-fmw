name             'oracle-fmw'
maintainer       'Jorge Quilcate'
maintainer_email 'quilcate.jorge@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Oracle Fusion Middleware 11g/12c'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'java'

%w{oracle redhat centos}.each do |p|
  supports p
end
