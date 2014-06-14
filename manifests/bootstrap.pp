
# Bootstrap prepares few things before proceeding with installation.
class dlang::bootstrap {
 
  # We will need to unzip DMD2 package.
  package { "unzip": }
  
  package { "curl": }
  
  # We will be downloading files with wget.
  if $::kernel == "Linux" {
    if ! defined(Package["wget"]) {
      package { "wget": }
    }
  }
  
  # Create directory where to download and extract binaries.
  file { $dlang::dir_download:
    ensure => directory,
  }
  
}
