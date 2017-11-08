class mysql {

  # package { 'mysql-server':
  package { 'mysql-server-5.6':
    provider => apt,
    ensure   => present,
    require  => Exec['apt.update'],
  }

  service { 'mysql':
    ensure  => running,
    # require => Package['mysql-server'],
    require => Package['mysql-server-5.6'],
  }

  file { '/etc/mysql/conf.d/custom.cnf':
    ensure  => present,
    content => "[mysqld]\nbind-address = 0.0.0.0",
    # require => Package['mysql-server'],
    require => Package['mysql-server-5.6'],
    notify  => Service['mysql']
  }

  exec { 'import-timezones':
    command => '/usr/bin/mysql_tzinfo_to_sql /usr/share/zoneinfo | /usr/bin/mysql -uroot mysql;',
    require => Service['mysql'],
  }

  exec { 'grant-privileges':
    command => '/usr/bin/mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO \'root\'@\'%\';"',
    require => Service['mysql'],
  }

}
