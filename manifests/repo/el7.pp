# Add the Varnish repo
class varnish::repo::el7 {

  $majorversionparts = split($::varnish::varnish_version, '[.]')
  $majorversion = $majorversionparts[0]

  case $majorversion {
    '5': {
      $repo = 'packagecloud'
    }
    default: {
      $repo = 'legacy'
    }
  }

  case $repo {
    'packagecloud': {
      yumrepo { 'varnish-cache':
        baseurl  => "https://packagecloud.io/varnishcache/varnish${majorversion}/el/${::operatingsystemmajrelease}/\$basearch",
        descr    => 'Varnish-cache RPM repository',
        enabled  => 1,
        gpgcheck => 0,
        priority => 10,
      }
    }
    'legacy': {
      yumrepo { 'varnish-cache':
        baseurl  => "https://repo.varnish-cache.org/redhat/varnish-${::varnish::varnish_version}/el7/",
        descr    => 'Varnish-cache RPM repository',
        enabled  => 1,
        gpgcheck => 0
      }
    }
  }

}
