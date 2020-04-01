service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'obaribau'@'localhost' IDENTIFIED BY '1234';"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'obaribau'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
