# == Class: pxe::setup::menu
#
# Create default menus
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

    pxe::menu { 'Main Menu':
        file      => 'default',
        template  => 'pxe/menu_default.erb';
    }

#    pxe::menu::entry { 'Installations':
#        file    => 'default',
#        append  => 'pxelinux.cfg/menu_install',
#    }

#    pxe::menu { 'Operating System ($arch)':
#        file  => 'menu_install',
#    }

#    pxe::menu::entry { 'Debian':
#        file    => 'menu_install',
#        append  => 'pxelinux.cfg/os_debian',
#    }

    pxe::menu { 'Debian':
        file  => 'os_debian',
    }

    pxe::menu::entry { 'Debian 6 squeeze amd64 Installation':
        file    => 'os_debian',
        kernel  => 'images/debian/amd64/squeeze/squeeze',
        append  => 'vga=791 initrd=images/debian/i386/squeeze/squeeze.gz',
    }

    pxe::menu::entry { 'Debian 7 wheezy amd64 Installation':
        file    => 'os_debian',
        kernel  => 'images/debian/amd64/wheezy/wheezy',
        append  => 'vga=791 initrd=images/debian/i386/wheezy/wheezy.gz',
    }

}
