
# Class: dlang
# Installs D programming language and DUB repository manager.
class dlang (
  
  # Folder where archive files are downloaded and extracted.
  $dir_download = "/opt/dlang",
  
  # PATH variable. Where to search for executables.
  $path = "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/local/bin",
  
  # CPU architecture.
  $cpu_word_size = "32"
 
) {
  
  # Do initial housekeeping.
  include dlang::bootstrap
 
}
