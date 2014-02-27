The scripts in this directory are copied into /var/www/cgi-bin rather
than symlinked so that the suexec mechanism will work.  This means
that changes in these scripts are not automatically refreshed.
