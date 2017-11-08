class apt {

  exec { 'apt.update':
    command => '/usr/bin/apt-get -y update',
  }

  package { 'python-software-properties':
    provider => apt,
    ensure   => latest,
    require  => Exec['apt.update'],
  }

}
