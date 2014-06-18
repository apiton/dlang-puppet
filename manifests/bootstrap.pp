
# Bootstrap prepares few things before proceeding with installation.
class dlang::bootstrap {
 
  # We will need to unzip DMD2 package.
  package { "unzip": }
  
  # DUB requires CURL.
  package { "curl": }
  
  # We download stuff with wget.
  package { "wget": }
  
  # Create directory where to download and extract binaries.
  file { $dlang::dir_download:
    ensure => directory,
  }
  
}
