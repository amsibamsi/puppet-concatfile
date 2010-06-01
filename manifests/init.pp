define concatfile(
  $dir,
  $owner = "0",
  $group = "0",
  $mode = "0644"
) {

  file {
    $dir:
      ensure => directory,
      checksum => mtime,
      recurse => true,
      purge => true,
      mode => $mode,
      owner => $owner,
      group => $group,
      notify => Exec[$dir];
    $name:
      ensure => present,
      checksum => md5,
      mode => $mode,
      owner => $owner,
      group => $group,
      notify => Exec[$dir];
  }

  exec {
    $dir:
      command => "find $dir -maxdepth 1 \\( -type f -or -type l \\) -print0 | sort -nz | xargs -0 cat > $name",
      refreshonly => true;
  }

}
