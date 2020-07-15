: '
if [ ! -z $INCLUDE_SERVER_PID ] ; then
    pump --shutdown
    unset INCLUDE_SERVER_PID
    unset INCLUDE_SERVER_PORT
    unset INCLUDE_SERVER_DIR
fi
'
