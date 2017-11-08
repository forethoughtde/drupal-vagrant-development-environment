class zip {

  package { 'zip':
    provider => apt,
    ensure   => latest,
    require  => Exec['apt.update'],
  }

}
