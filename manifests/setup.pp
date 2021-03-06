# == Class: pxe::setup
#
# Setup PXE server with dhcp + tftp
#
# === Variables
# [*dhcp_interfaces*]
# [*tftp_root*]
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

    package { 'gzip':
        ensure => present
    }

    service { 'isc-dhcp-server':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => Package['isc-dhcp-server']
    }

    service { 'tftpd-hpa':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => Package['tftpd-hpa']
    }

    file { '/etc/dhcp/dhcpd.conf':
        ensure  => present,
        content => template('pxe/dhcpd.conf.erb'),
        require => Package['isc-dhcp-server'],
        notify  => Service['isc-dhcp-server']
    }

    file { '/etc/default/isc-dhcp-server':
        ensure  => present,
        content => template('pxe/isc-dhcp-server.default.erb'),
        require => Package['isc-dhcp-server'],
        notify  => Service['isc-dhcp-server']
    }

    file { '/etc/default/tftpd-hpa':
        ensure  => present,
        content => template('pxe/tftpd-hpa.default.erb'),
        require => Package['tftpd-hpa'],
        notify  => Service['tftpd-hpa']
    }

    include pxe::setup::menu
    include pxe::setup::debian
    include pxe::setup::centos

    @@nagios_service { "check_pxe_dhcp_${::fqdn}":
        check_command       => "check_ssh_process!1!3!dhcpd!${::ssh_port}",
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => "check_pxe_dhcp_${::fqdn}"
    }

    @@nagios_service { "check_pxe_tftp_${::fqdn}":
        check_command       => "check_ssh_process!1!3!in.tftpd!${::ssh_port}",
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => "check_pxe_tftp_${::fqdn}"
    }
}
