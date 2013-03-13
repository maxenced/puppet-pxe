# == Class: pxe::setup::centos
#
# Setup default images/menu for CentOS installation
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
class pxe::setup::centos {
    include pxe
    $centos = {
        'arch' => ['amd64'],
        'ver'  => ['6.3'],
        'os'   => 'centos'
    }

    resource_permute('pxe::images', $centos)

}
