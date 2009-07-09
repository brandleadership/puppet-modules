# DHCP
# ====
class dhcp::server {
	package { "dhcp3-server": ensure => installed }

	service { "dhcp3-server":
		ensure  => running,
		require => Package["dhcp3-server"],
		pattern => '/usr/sbin/dhcpd3'
	}

	file {"/etc/dhcp3/dhcpd.conf":
		ensure  => file,
		content => template("dhcp/etc/dhcp3/dhcpd.conf"),
		require => Package["dhcp3-server"],
		notify  => Service["dhcp3-server"]
	}

	file {"/etc/dhcp3/dhcpd.conf.d":
		ensure  => directory,
		require => Package["dhcp3-server"],
	}

	file {"/etc/dhcp3/dhcpd.conf.d/dummy":
		ensure  => file,
		content => template("dhcp/etc/dhcp3/dhcpd.conf.d/dummy"),
		require => File["/etc/dhcp3/dhcpd.conf.d"],
		notify  => Service["dhcp3-server"]
	}
}