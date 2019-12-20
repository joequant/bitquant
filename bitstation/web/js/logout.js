function logout() {
    var out = window.location.href.replace(/:\/\//, '://log:out@');

    jQuery.get(out).error(function() {
        window.location = '/dokuwiki';
    });
    return false;
}
