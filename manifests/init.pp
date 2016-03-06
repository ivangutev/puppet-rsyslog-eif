class rsyslog (
  $remote_syslog_servers = [],
  $syslog_conf_template = "",
  $queue_max_disk_space = "10g"
)

{

  file { "/etc/rsyslog.conf":
    ensure => "file",
    owner => "root",
    group => "root",
    mode => "0644",
    content => pick( inline_template($syslog_conf_template), template("rsyslog/rsyslog.conf.erb")),
    notify => Service["rsyslog"]
  }

  service { "rsyslog":
    ensure => "running",
    enable => true,
    require => Service["ntp"]
  }
}
