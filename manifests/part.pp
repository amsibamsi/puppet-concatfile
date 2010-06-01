define concatfile::part(
  $source = "",
  $content = "",
  $file = "",
  $owner = "0",
  $group = "0",
  $mode = "0644"

) {

  $dir = dirname($name)

  File {
    owner => $owner,
    group => $group,
    mode => $mode,
    require => File[$dir],
    notify => Exec[$dir],
  }

  # This is why we should have an elsif ;-)
  if ($source != "" and $content == "" and $file == "") {
    file { $name: source => $source }
  } else {
    if ($source == "" and $content != "" and $file == "") {
      file { $name: content => $content }
    } else {
      if ($source == "" and $content == "" and $file != "") {
        file { $name: ensure => $file }
      } else {
        if ($source == "" and $content == "" and $file == "") {
          file { $name: }
        } else {
          err "Only one of the parameters source, content, file can be specified."
        }
      }
    }
  }

}
