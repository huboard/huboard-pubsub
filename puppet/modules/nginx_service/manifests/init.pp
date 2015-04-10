class nginx_service(
  $package_name = "nginx"
){
  package { 'nginx-extras': ensure => present; } ->

  package { "nginx":
    ensure => "present",
  }

  service{ 'nginx':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package["nginx-extras"],
        subscribe  => [
          File['/etc/nginx/sites-available/default'],
        ]
      }

  file { '/etc/nginx/sites-available/default':
    ensure    => present,
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    source   => 'puppet:///modules/nginx_service/etc.nginx.sites-available.default',
  }
}
