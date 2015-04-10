exec { 'apt-update':
  command => "/usr/bin/apt-get update -y"
}
Exec["apt-update"] -> Package <| |> 
class { 'nginx_service':}
package {
  'libffi-dev': ensure => "present";
  } ->
  class { 'ruby_install': 
    ruby_version => "2.2.1",
  }

  class { 'redis':
    version            => '2.8.12',
  }
