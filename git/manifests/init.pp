# Git
# ===
class git::client {
	package { "git-core": ensure => installed }
}