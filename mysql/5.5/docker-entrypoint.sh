#!/bin/bash
set -e
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-"root"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
MYSQL_TEST="${DATA_DIR}/mysql"

#
#  Mysql setup
#
run_mysql() {
if [[ ! -d ${DATA_TEST} ]]; then
        echo "===> Initializing mysql database... "
	   	mysql_install_db --user=mysql --ldata=${DATA_DIR}
        echo "===> System databases initialized..."
	   	# Start mysql
		mkdir /var/log/mysqld -p
                touch /var/log/mysqld/mysqld.log
                chown mysql:mysql -R /var/log/mysqld
                mysqld --user mysql > /dev/null 2>&1 &


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
        echo "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "GRANT ALL ON *.* to 'root'@'127.0.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    fi
else
    if [[ $MYSQL_USER == "root" ]]; then
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

sleep 2
mysql -uroot  < $tfile
kill -9 `ps -aux|grep mysql|grep -v grep|awk '{print $2}'`
sleep 1
rm -f $tfile
fi
}
run_mysql

echo "==================================================================================================="
echo "			     You can now connect to this MySQL5.5 server using:				 "
echo "													 "
echo "  MYSQL_ROOT_PASSWORD DEFAULT IS NULL.                                                             "
echo "  MYSQL_USER:$MYSQL_USER, MYSQL_PASSWORD:$MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD:$MYSQL_ROOT_PASSWORD " 
echo "  mysql -u$MYSQL_USER -p$MYSQL_PASSWORD or $MYSQL_ROOT_PASSWORD --host <host> --port <port>        "
echo "                                                                        				 "
echo "  Please remember to change the above password as soon as possible!					 "
echo "==================================================================================================="

mysqld --user mysql &> /dev/null
fg

