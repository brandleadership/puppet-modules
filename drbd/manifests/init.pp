# DRBD
# ====
class drbd::daemon {
	package { "drbd8-utils": ensure => installed }
	package { "drbd8-modules-2.6-xen-686": ensure => installed }
}