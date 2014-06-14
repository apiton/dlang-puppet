
# Installs DUB repository management.
class dlang::dub (
  
  # URL where DUB archive is located.
  $url_tgz = "http://code.dlang.org/files/dub-0.9.21-linux-x86.tar.gz",

  # Full path to download and extraction folder.
  $dir_download = "${dlang::dir_download}/dub",

) {
  
  include dlang::dmd2
  
  # Create directory where we will download DUB binaries.
  file { $dlang::dub::dir_download:
    require => Class["dlang::dmd2"],
    ensure => directory,
  }
  
  
  
}