# Networking
# ==========
class network::interface::common {
	# Workaround for Debian Bug #159884
	file { "/etc/network/interfaces.d/": ensure => directory }

	exec { "Generating /etc/network/interfaces":
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command     => "cat $(run-parts --list /etc/network/interfaces.d) > /etc/network/interfaces",
		refreshonly => true,
		require     => File["/etc/network/interfaces.d/"]
	}
}

class network::bridge {
	package {"bridge-utils": ensure => installed}
}

# Workaround for Debian Bug #159884
define network::interface($iface_name, $iface_address = "", $iface_netmask = "", $iface_gateway = "", $iface_nameservers = "", $iface_search = "", $iface_routes = [], $iface_bridge_ports = [], $iface_options = "", $iface_template = "network/etc/network/interfaces.d/static") {
	include network::interface::common

#	TODO: We only would like to install if there's some bridge_ports
#	case $iface_bridge_ports {
#		[]: {}
#		default: { include network::bridge }
#	}

	file {"/etc/network/interfaces.d/$title":
		ensure  => present,
		content => template("$iface_template"),
		require => File["/etc/network/interfaces.d/"],
		notify  => Exec["Generating /etc/network/interfaces"]
	}
}

class network::interfaces {
	network::interface {"10-lo":
		iface_name        => "lo",
		iface_template    => "network/etc/network/interfaces.d/lo"
	}
}

class network::interface::primary {
	network::interface {"20-primary":
		iface_name        => "eth0",
		iface_address     => $host_address,
		iface_gateway     => $network_gateway,
		iface_netmask     => $network_netmask,
		iface_nameservers => $network_nameservers,
		iface_search      => $network_search,
		iface_routes      => $network_routes,
		iface_options     => $network_options,
		iface_template    => "network/etc/network/interfaces.d/static"
	}
}
