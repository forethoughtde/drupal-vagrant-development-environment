class curl {

  package { 'curl':
    provider => apt,
    ensure   => latest,
    require  => Exec['apt.update'],
  }

}
