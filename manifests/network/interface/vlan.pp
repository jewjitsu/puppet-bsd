# Define: bsd::network::interface::vlan
#
# Handle the creation and configuration of vlan(4) interfaces.
#
define bsd::network::interface::vlan (
  $id,
  $device,
  $ensure      = 'present',
  $address     = [],
  $state       = 'up',
  $description = undef,
) {

  $if_name = $name
  validate_re($if_name, ['vlan'])

  validate_re(
    $state,
    '(up|down)',
    'The $state can only be \'up\' or \'down\'.'
  )

  $config = {
    id      => $id,
    device  => $device,
    address => $address,
  }

  case $::kernel {
    'FreeBSD': {
      $vlan_values = get_rc_conf_vlan($config)
    }
    'OpenBSD': {
      $vlan_values = get_hostname_if_vlan($config)
    }
  }

  bsd::network::interface { $if_name:
    ensure      => $ensure,
    description => $description,
    values      => $vlan_values,
  }
}
