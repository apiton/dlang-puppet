
define dlang::download (
  $url = $title,
  $destination,
) {
  
  include dlang
  
  # Download package with all binaries.
  exec { "dlang::download::${url}":
    #require => $require,
    command => "wget --output-document ${destination} '${url}'",
    creates => $destination,
    path => $dlang::path,
  }
  
}