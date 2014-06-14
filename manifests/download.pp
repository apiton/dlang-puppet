
define dlang::download (
  #$require,
  $url = $title,
  $destination,
) {
  
  # Install wget.
  if $::kernel == "Linux" {
    if ! defined(Package["wget"]) {
      package { "wget":
        ensure => present,
        before => Exec["dlang::download::${url}"],
      }
    }
  }
  
  # Download package with all binaries.
  exec { "dlang::download::${url}":
    #require => $require,
    command => "wget --output-document ${destination} '${url}'",
    creates => $destination,
    path => $dlang::path,
  }
  
}