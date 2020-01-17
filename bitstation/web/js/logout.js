function logout() {
    var out = window.location.href.replace(/:\/\//, '://log:out@');

    jQuery.get(out).always(function() {
        jQuery.get('/jupyterhub/hub/logout').always(function () {
        window.location = '/dokuwiki';
});
    });
    return false;
