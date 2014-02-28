#!/bin/bash 
echo "Content-type: text/plain"
echo ""
echo "Refresh scripts"
SCRIPT_DIR=%SCRIPT_DIR%
cp $SCRIPT_DIR/cgi-bin/bittrader/*.sh /var/www/cgi-bin/bittrader
# I put the following line using odd quoting so that when I
# do the script dir substitutions, the follow line doesn't
# get changed
sed -e "s!""%""SCRIPT_DIR""%""!$SCRIPT_DIR!g" -i *.sh
echo "Done"
