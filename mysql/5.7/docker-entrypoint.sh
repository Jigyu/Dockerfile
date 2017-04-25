#!/bin/bash
set -e
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-"root"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"$(pwgen -s 12 1)"}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-$(pwgen -s 12 1)}

#
#  Mysql setup
#
run_mysql() {

    echo "===> Initializing mysql database... "
    cd /usr/bin/
    mysqld --initialize-insecure --user=mysql &> /tmp/tmp.txt 
    mysqld --daemonize > /dev/null 2>&1 
    pass=`tail -1 /tmp/tmp.txt |awk -F ": " '{print $2}'`
    


tfile=/tmp/temp.sql
if [[ $MYSQL_DATABASE != "" ]]; then
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
    echo "FLUSH PRIVILEGES;" >> $tfile

    if [[ $MYSQL_USER == 'root' ]]; then
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    else
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    fi
else
    if [[ $MYSQL_USER == 'root' ]]; then
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    else
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to 'root'@'127.0.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    fi
       
fi

sleep 1
mysql < /tmp/temp.sql

rm -f $tfile
rm -f /tmp/tmp.txt

kill -9 `ps -aux |grep mysqld|grep -v "grep" |awk '{print $2}'`
}
run_mysql

echo "========================================================================"
echo "You can now connect to this MySQL5.7 server using:"
echo "                                                                        "
echo "  MYSQL_USER:$MYSQL_USER, MYSQL_PASSWORD:$MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD:$MYSQL_ROOT_PASSWORD " 
echo "  mysql -u$MYSQL_USER -p$MYSQL_PASSWORD or $MYSQL_ROOT_PASSWORD --host <host> --port <port>"
echo "                                                                        "
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"

exec mysqld --daemonize
