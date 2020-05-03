mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default3
mv /etc/nginx/sites-available/default2 /etc/nginx/sites-available/default
mv /etc/nginx/sites-available/default3 /etc/nginx/sites-available/default2
service nginx restart
