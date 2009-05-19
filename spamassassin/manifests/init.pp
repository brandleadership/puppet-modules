# Spamassassin
# ============
class spamassassin::daemon {
        package {"spamassassin": ensure => installed }

	service {"spamassassin":
		ensure  => running,
		require => Package["spamassassin"]
	}

	file {"/etc/default/spamassassin":
		ensure  => present,
		content => template("spamassassin/etc/default/spamassassin"),
		notify  => Service["spamassassin"]
	}
}

