# == Class: pxe::setup::debian
#
# Setup default images/menu for Debian installation
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
class pxe::setup::debian {
    include pxe
    $debian = {
        'arch' => ['amd64'],
        'ver'  => ['squeeze','wheezy'],
        'os'   => 'debian'
    }

    resource_permute('pxe::images', $debian)

}
