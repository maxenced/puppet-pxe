# == Class: pxe::preseed
#
# Setup web server and preseed files
#
# === Variables
#
# === Authors
#
# Author Name Maxence Dunnewind (<maxence@dunnewind.net>)
#
# === Copyright
#
# Copyright 2012 Maxence Dunnewind
#
class pxe::preseed {
    include apache
    apache::vhost { "${::fqdn}":
        priority           => '10',
        vhost_name         => "${::fqdn}",
        port               => '80',
        docroot            => '/srv/www/preseed',
        configure_firewall => false
    }

    file { '/srv/www':
        ensure => directory,
        owner  => 'www-data',
        group  => 'www-data'
    }

    file { '/srv/www/preseed':
        ensure => directory,
        owner  => 'www-data',
        group  => 'www-data'
    }

    #Preseeds
    file { '/srv/www/preseed/wheezy.cfg':
        content => template('pxe/preseed.cfg.erb')
    }
    file { '/srv/www/preseed/squeeze.cfg':
        content => template('pxe/preseed.cfg.erb')
    }
}
