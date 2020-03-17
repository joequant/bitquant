#!/bin/bash
# sudo portion of r package installations

echo "Running r installation"
if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi

pushd /home/user

# Without this the installation will try to put the R library in the
# system directories where it does not have permissions

R_VERSION=$(R --version | head -1 | cut -d \  -f 3 | awk -F \. {'print $1"."$2'})

/usr/bin/R -e 'IRkernel::installspec(prefix="/usr", user=FALSE)'

if [ -d /home/user/git/shiny-server ]
then echo "Installing shiny server"
pushd /home/user/git/shiny-server
sed -i -e s!bin/node!! -e s!bin/npm!! CMakeLists.txt
sed -i -e s!add_subdirectory\(external/node\)!! CMakeLists.txt
popd
make -C /home/user/git/shiny-server install
ln -s -f  ../lib/shiny-server/bin/shiny-server /usr/bin/shiny-server
#Create shiny user. On some systems, you may need to specify the full path to 'useradd'
useradd -r shiny -s /bin/false -M

# Create log, config, and application directories
mkdir -p /var/log/shiny-server
mkdir -p /var/www/shiny-server
mkdir -p /var/lib/shiny-server
chown shiny /var/log/shiny-server
mkdir -p /etc/shiny-server
cp -r /usr/$LIBDIR/R/library/shiny/examples/*  /var/www/shiny-server
fi
popd
