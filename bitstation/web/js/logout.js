function logout() {
    var out = window.location.href.replace(/:\/\//, '://log:out@');
    jQuery.get(out).always(function() {
        jQuery.get('/jupyterhub/hub/logout').always(function () {});
    jQuery.get('/dokuwiki/doku.php?do=logout').always(function() {
    window.location.assign('/dokuwiki'); reload(true);
});
    });
    return false;
}
