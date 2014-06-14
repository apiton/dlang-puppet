
# Bootstrap prepares few things before proceeding with installation.
class dlang::bootstrap {
 
  # We will need to unzip DMD2 package.
  package { "unzip":
    ensure => installed,
  }
  
  # We will be downloading files with wget.
  if $::kernel == "Linux" {
    if ! defined(Package["wget"]) {
      package { "wget":
        ensure => present,
      }
    }
  }
  
  # Create directory where to download and extract binaries.
  file { $dlang::dir_download:
    ensure => directory,
  }
  
}
