docker run --privileged -d -p 80:80 -p 443:443 joequant/bitstation &
echo "please connect to http://$(boot2docker ip 2> /dev/null)"
