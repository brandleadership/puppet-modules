# Locales
# =======
#
# Installs the package locales.
# Executes locale-gen from /etc/locale.gen.
# Adds the file /etc/locale.gen with content locales/etc/locale.gen.
#
class locales::conf {
        package { "locales": ensure => installed }

        exec { "locale-gen":
		path        => ["/usr/local/sbin", "/usr/local/bin", "/usr/sbin", "/usr/bin", "/sbin", "/bin"],
                command     => "locale-gen",
                refreshonly => true,
		subscribe   => File["/etc/locale.gen"],
		require     => Package["locales"]
        }

	file { "/etc/locale.gen":
		ensure  => file,
		content => template("locales/etc/locale.gen")
	}
}
