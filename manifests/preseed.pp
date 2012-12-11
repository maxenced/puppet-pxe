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
    include nginx
    nginx::vhost { 'preseed':
        docroot => '/srv/www/preseed'
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
}
