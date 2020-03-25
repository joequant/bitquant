<?php
$CONFIG = array (
    "log_type" => "file",
    "logfile" => "/var/lib/nextcloud/data/nextcloud.log",
    "datadirectory" => "/var/lib/nextcloud/data",
    "updatechecker" => false,
    "check_for_working_htaccess" => false,
    "asset-pipeline.enabled" => false,
    "assetdirectory" => '/var/lib/nextcloud',
    "preview_libreoffice_path" => '/usr/bin/libreoffice',
    'memcache.local' => '\OC\Memcache\APCu',
    "apps_paths" => array(
        0 =>
        array (
            'path'=> '/usr/share/nextcloud/apps',
            'url' => '/apps',
            'writable' => false,
        ),
        1 =>
        array (
            'path' => '/var/lib/nextcloud/apps',
            'url' => '/apps-appstore',
            'writable' => true,
        ),
    ),
);
