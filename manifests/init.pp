# Class: dhcpserver
# ===========================
#
# Full description of class dhcpserver here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'dhcpserver':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class dhcpserver {

    file { "/etc/dhcp":
          ensure => directory
    }
    package { "dhcp":
        ensure => installed,
    }->
    file { "/etc/dhcp/dhcpd.conf":
        source => "puppet:///modules/$name/dhcp/dhcpd.conf"
        notify => Service ['dhcpd']
    }->
    file { "/etc/dhcp/conf.d" :
        source => "puppet:///modules/$name/dhcp/conf.d",
        recurse => true,
        ensure => directory,
        owner => root,
        notify => Service ['dhcpd']
    }->
    service { "dhcpd": 
        ensure => running,
        enable => true,
    }

}
