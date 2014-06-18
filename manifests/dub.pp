
# Installs DUB repository management.
class dlang::dub (
  
  # URL where DUB archive is located.
  $url_tgz = "http://code.dlang.org/files/dub-0.9.21-linux-x86.tar.gz",

  # Full path to download and extraction folder.
  $dir_download = "${dlang::dir_download}/dub",

) {
  
  # Bootstrap...
  include dlang
  
  # Create directory where we will download DUB binaries.
  file { $dlang::dub::dir_download:
    require => Class["dlang"],
    ensure => directory,
  }
  
  # Download DUB executable.
  dlang::download { $url_tgz:
    require => File[$dlang::dub::dir_download],
    before => Exec["dub.tar.gz extract"],
    destination => "${dir_download}/dub.tar.gz",
  }
  
  # Extract archive.
  exec { "dub.tar.gz extract":
    command => "tar -zxvf ${dir_download}/dub.tar.gz -C ${dir_download}",
    creates => "${dir_download}/dub",
    path => $dlang::path,
  }
  
  # Copy executable into /usr/local/bin.
  exec { "dub copy bin": 
    require => Exec["dub.tar.gz extract"],
    command => "cp ${dir_download}/dub /usr/local/bin/dub",
    creates => "/usr/local/bin/dub",
    path => $dlang::path,
  }

}