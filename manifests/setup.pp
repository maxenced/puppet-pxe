# == Class: pxe::setup
#
# Setup PXE server with dhcp + tftp
#
# === Variables
# [*dhcp_interfaces*]
# [*tftp_root*]
# [*domain_name*]
# [*dns_servers*]
# [*router*]
#
# === Authors
#
# Author Name Maxence Dunnewind (<maxence@dunnewind.net>)
#
# === Copyright
#
# Copyright 2012 Maxence Dunnewind
#
class pxe::setup {

    file { $::tftp_root:
        ensure => directory
    }

    package { ['isc-dhcp-server', 'tftpd-hpa']:
        ensure  => present,
        require => File[$::tftp_root]
    }

    service { 'isc-dhcp-server':
        ensure  => running,
        enable  => true,
        require => Package['isc-dhcp-server']
    }

    service { 'tftpd-hpa':
        ensure  => running,
        enable  => true,
        require => Package['tftpd-hpa']
    }

    file { '/etc/dhpc/dhcpd.conf':
        ensure  => present,
        source  => template('pxe/dhcpd.conf.erb'),
        require => Package['isc-dhcp-server'],
        notify  => Service['isc-dhcp-server']
    }

    file { '/etc/default/isc-dhcp-server':
        ensure  => present,
        source  => template('pxe/isc-dhcp-server.default.erb'),
        require => Package['isc-dhcp-server'],
        notify  => Service['isc-dhcp-server']
    }

    file { '/etc/default/tftpd-hpa':
        ensure  => present,
        source  => template('pxe/tftpd-hpa.default.erb'),
        require => Package['tftpd-hpa'],
        notify  => Service['tftpd-hpa']
    }
}
