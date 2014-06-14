
# Installs D 2.0 programming language.
class dlang::dmd2 (

  # URL of zip with DMD2 binaries.
  $url_zip = "http://downloads.dlang.org/releases/2014/dmd.2.065.0.zip",
  
  # Full path to download and extraction folder.
  $dir_download = "${dlang::dir_download}/dmd2",

) {
  
  # Bootstrap...
  include dlang
  
  # Create directory where we will download DMD binaries.
  file { $dlang::dmd2::dir_download:
    require => Class["dlang"],
    ensure => directory,
  }

  # Download package with all binaries.
  exec { "dmd2.zip download":
    require => File[$dlang::dmd2::dir_download],
    command => "wget --output-document ${dir_download}/dmd2.zip '${url_zip}'",
    creates => "${dir_download}/dmd2.zip",
    #logoutput => on_failure,
    path => $dlang::path,
  }
 
  # Unzip archive.
  exec { "dmd2.zip unzip":
    require => Exec["dmd2.zip download"],
    command => "unzip ${dir_download}/dmd2.zip -d ${dir_download}",
    creates => "${dir_download}/dmd2",
    path => $dlang::path,
  }
  
  # Create directory where we will place binaries.
  file { "${dir_download}/bin":
    require => Exec["dmd2.zip unzip"],
    ensure => directory,
  }
  
  # Place binaries into the new directory.
  exec { "dmd2.zip copy binaries":
    require => File["${dir_download}/bin"],
    command => "cp -R ${dir_download}/dmd2/linux/bin${dlang::cpu_word_size}/. ${dir_download}/bin/",
    creates => "${dir_download}/bin/dmd",
    path => $dlang::path,
  }
  
  # Clear the redudndant files ~350Mb.
  exec { "dmd2 remove files":
    #require => Exec["dmd2.zip copy binaries"],
    subscribe => Exec["dmd2.zip copy binaries"],
    refreshonly => true,
    command => "rm -rf ${dir_download}/dmd2/*",
    path => $dlang::path,
  }
  
  # Copy configuration file into /etc.
  exec { "dmd2 copy config":
    require => Exec["dmd2.zip unzip"],
    command => "cp ${dir_download}/bin/dmd.conf /etc",
    creates => "/etc/dmd.conf",
    path => $dlang::path,
  }
  
  # Copy executables into /usr/local/bin.
  exec { "dmd2 copy bin":
    require => Exec["dmd2 copy config"],
    command => "cp -R ${dir_download}/bin/. /usr/local/bin/",
    creates => "/usr/local/bin/dmd",
    path => $dlang::path,
  }
 
}
