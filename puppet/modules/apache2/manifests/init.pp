class apache2 {

  package { 'apache2':
    provider => apt,
    ensure   => latest,
    require  => Exec['apt.update'],
  }

  service { 'apache2':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['apache2'],
  }

  file { '/var/www':
    ensure  => link,
    target  => '/vagrant/web',
    mode    => 0644,
    force   => true,
    require => Package['apache2'],
  }

  file { '/etc/apache2/mods-enabled/env.load':
    ensure  => link,
    target  => '../mods-available/env.load',
    force   => true,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/headers.load':
    ensure  => link,
    target  => '../mods-available/headers.load',
    force   => true,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/rewrite.load':
    ensure  => link,
    target  => '../mods-available/rewrite.load',
    force   => true,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/ssl.load':
    ensure  => link,
    target  => '../mods-available/ssl.load',
    force   => true,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  ## certs

  file { '/etc/apache2/certs':
    ensure  => directory,
    require => Package['apache2'],
  }

  file { '/etc/apache2/certs/ca_digitalspital_chain.cert.pem':
    ensure  => present,
    source  => 'puppet:///modules/apache2/ca_digitalspital_chain.cert.pem',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => [
      Package['apache2'],
      File['/etc/apache2/certs'],
    ],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/certs/localhost.cert.pem':
    ensure  => present,
    source  => 'puppet:///modules/apache2/localhost.cert.pem',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => [
      Package['apache2'],
      File['/etc/apache2/certs'],
    ],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/certs/localhost.key.pem':
    ensure  => present,
    source  => 'puppet:///modules/apache2/localhost.key.pem',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => [
      Package['apache2'],
      File['/etc/apache2/certs'],
    ],
    notify  => Service['apache2'],
  }

  ####

  ## sites

  file { '/etc/apache2/sites-enabled/000-default':
    ensure  => absent,
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/sites-available/default.conf':
    ensure  => present,
    source  => 'puppet:///modules/apache2/default.conf',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/sites-enabled/default.conf':
    ensure  => link,
    target  => '../sites-available/default.conf',
    require => File['/etc/apache2/sites-available/default.conf'],
    notify  => Service['apache2'],
  }

  ####

}
