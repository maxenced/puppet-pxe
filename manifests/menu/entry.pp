# Class: pxe::menu::entry
#
# This is a utility class for creating menu entries for pxe booting.
#
# Parameters:
#
# [*file*]
#   In which file the entry should be put
# [*template*]
#   Path of template used to generate the menu entry, def. pxe/menuentry.erb
# [*order*]
#   Order in the file (used by concat module)
# [*kernel*]
#   Kernel to use, default 'menu.c32'
# [*append*]
#   String to append to command line (should contains at least initrd path)
# [*menutitle*]
#   Title of the menu, defaults to $title
# [*preseed*]
#   Path of pressed file (if any) relativly to webserver root
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define pxe::menu::entry (
    $file,
    $template   = 'pxe/menuentry.erb',
    $order      ='10',
    $kernel     = 'menu.c32',
    $append     = '',
    $menuetitle = '',
    $preseed    = ''
) {

  if $menutitle == '' {
    $label = $title
  } else {
    $label = $menutitle
  }

  $tftp_root = $::pxe::tftp_root
  $fullpath  = "${tftp_root}/pxelinux.cfg"

  $file_string   = inline_template($file)
  $label_string  = inline_template($label)

  $append_full = ''
  if $preseed != '' {
      $append_full = "${append} auto=true priority=critical url=http://${::fqdn}/${preseed} interface=eth0"
  }

  concat::fragment { "${file_string}-menu-entry-${title}":
    order   => $order,
    target  => "${fullpath}/${file_string}",
    content => template('pxe/menuentry.erb'),
  }

}
