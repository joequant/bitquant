<?php
$CONFIG = array (
  'log_type' => 'syslog',
  'updatechecker' => false,
  'check_for_working_htaccess' => false,
  'asset-pipeline.enabled' => false,
  'assetdirectory' => '/var/lib/nextcloud',
  'preview_libreoffice_path' => '/usr/bin/libreoffice',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/usr/share/nextcloud/apps',
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
  'instanceid' => 'oce6pv0fp6u8',
  'passwordsalt' => 'anT09gffXAl4/T4lggiN4oqTH/k41t',
  'secret' => '++QyPQaGlwYNxY47JSLlw/g93taBbCreOnrYEWhNShemn/4B',
  'trusted_domains' => 
  array (
    0 => 'localhost',
  ),
  'dbtype' => 'sqlite',
  'version' => '18.0.2.2',
  'overwrite.cli.url' => 'http://localhost/nextcloud',
  'installed' => true,
);
