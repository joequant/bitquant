ErrorDocument 403 /nextcloud/core/templates/403.php
ErrorDocument 404 /nextcloud/core/templates/404.php

AddDefaultCharset utf-8

<IfModule mod_php.c>
php_value upload_max_filesize 10G
php_value post_max_size 10G
php_value memory_limit 512M
php_value mbstring.func_overload 0
php_value always_populate_raw_post_data -1
php_value default_charset 'UTF-8'
php_value output_buffering off
</IfModule>

<IfModule mod_fcgid.c>
    <IfModule mod_setenvif.c>
        <IfModule mod_headers.c>
            SetEnvIfNoCase ^Authorization$ "(.+)" XAUTHORIZATION=
            RequestHeader set XAuthorization %{XAUTHORIZATION}e env=XAUTHORIZATION
        </IfModule>
    </IfModule>
</IfModule>

<IfModule mod_rewrite.c>
    RewriteEngine on
    RewriteBase /nextcloud/
    RewriteRule .* - [env=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    RewriteRule ^remote/(.*) remote.php [QSA,L]
</IfModule>

<IfModule mod_headers.c>
    <FilesMatch "\.(css|js)$">
        Header set Cache-Control "max-age=7200, public"
    </FilesMatch>
    Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"
</IfModule>
