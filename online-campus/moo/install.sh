set -e -v
cat <<EOF >> /etc/dnf/dnf.conf
fastestmirror=true
excludepkgs=filesystem,chkconfig
max_parallel_downloads=10
EOF

source /tmp/proxy.sh

dnf upgrade --best --nodocs --allowerasing --refresh -y -x chkconfig -x filesystem
dnf --setopt=install_weak_deps=False --best --allowerasing install -v -y --nodocs \
    apache sudo wget gcc make byacc
useradd user
cp /tmp/startup.sh /home/user/startup.sh
chmod a+x /home/user/startup.sh
chmod a+rx /home/user
cd /var/www/html
ln -s /home/user/moo/encore .
