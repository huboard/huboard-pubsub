class ruby_install(
  $ruby_version = "2.2.1",
  $user = "vagrant"
){

  rbenv::install { "${user} rbenv":
    user    => $user
  }

  rbenv::compile { "${user}/${ruby_version}":
    user    => $user,
    ruby   => $ruby_version,
    global  => true,
    require => [
      Rbenv::Install["${user} rbenv"],
    ]
  }
}


