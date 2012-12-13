# == Class: pxe::setup::menu
#
# Create default menus
# The menu are organized in 2 ways:
# - pxe::menu will create a new file with name as title
#   ex : pxe::menu { 'Debian OS':
#           file => 'os_debian', #Will create os_debian
#           root => 'menu_install', #Will reference the file in menu_install
#        }
#   will create a file os_debian with title 'Debian OS'
# - pxe::menu::entry create a new entry in a file
#     The file *must* be created with pxe::menu.
#   ex : pxe::menu::entry { 'Squeeze':
#        file => 'os_debian', #name of the file
#        kernel => 'images/debian/release/arch/linux', #path to kernel
#        append => 'initrd=images/debian/release/arch/initrd.gz' #path to initrd
#   }
#
#  Note that default and menu_install files are defined automatically
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
class pxe::setup::menu {

    include pxe

    pxe::menu { 'Debian':
        file    => 'os_debian',
        root    => 'menu_install'
    }

    pxe::menu::entry { 'Debian 6 squeeze amd64 Installation':
        file    => 'os_debian',
        kernel  => 'images/debian/squeeze/amd64/linux',
        append  => 'vga=791 initrd=images/debian/squeeze/amd64/initrd.gz',
    #   preseed => 'squeeze.cfg'
    }

    pxe::menu::entry { 'Debian 7 wheezy amd64 Installation':
        file    => 'os_debian',
        kernel  => 'images/debian/wheezy/amd64/linux',
        append  => 'vga=791 initrd=images/debian/wheezy/amd64/initrd.gz',
    #   preseed => 'wheezy.cfg'
    }

}
