class php7 {

  # Choose either 'php7.0', 'php7.1' or 'php7.2' to install the corresponding PHP version from the package repository
  # See: https://launchpad.net/~ondrej/+archive/ubuntu/php/?field.series_filter=trusty

  exec { 'php7.add-package-repository':
    command => '/usr/bin/add-apt-repository -y ppa:ondrej/php; /usr/bin/apt-get -y update',
    require => Package['python-software-properties'],
  }

  package { 'php7.0':
    provider => apt,
    ensure   => latest,
    require  => Exec['php7.add-package-repository'],
  }

  package { 'php7.0-cli':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-curl':
    provider => apt,
    ensure   => latest,
    require  => [
      Package['curl'],
      Package['php7.0'],
    ],
  }

  package { 'php7.0-dev':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-gd':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-intl':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-mbstring':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-mysql':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php-xdebug':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-xsl':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php7.0-zip':
    provider => apt,
    ensure   => latest,
    require  => [
      Package['zip'],
      Package['php7.0']
    ],
  }

  package { 'libapache2-mod-php7.0':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'php-pear':
    provider => apt,
    ensure   => latest,
    require  => Package['php7.0'],
  }

  package { 'libsasl2-dev':
    provider => apt,
    ensure   => latest,
    require  => Exec['apt.update'],
  }

  file { '/etc/php/7.0/apache2/conf.d/xdebug.ini':
    ensure  => present,
    source  => 'puppet:///modules/php7/xdebug.ini',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => [
      Package['apache2'],
      Package['php-xdebug'],
    ],
    notify  => Service['apache2']
  }

  file { '/etc/php/7.0/cli/conf.d/xdebug.ini':
    ensure  => present,
    source  => 'puppet:///modules/php7/xdebug.ini',
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => [
      Package['apache2'],
      Package['php-xdebug'],
    ],
    notify  => Service['apache2']
  }

}
