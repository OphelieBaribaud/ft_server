FROM debian:buster

#installation de nginx
RUN apt-get update && apt-get install -y --no-install-recommends
RUN apt-get install -y nginx
RUN rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY ./srcs/default /etc/nginx/sites-available
COPY ./srcs/default2 /etc/nginx/sites-available
COPY ./srcs/autoindex.sh ./
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
RUN rm /var/www/html/index.nginx-debian.html

#installation de mySQL && téléchargement de PHP
RUN apt-get install -y default-mysql-server default-mysql-client
RUN apt-get install -y php-mysql php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-cli php-ldap php-zip php-curl
#creation de la database et d'un user dans MYSQL à l'aide d'un script
COPY ./srcs/wordpress.sql /tmp
COPY ./srcs/init-mysql.sh /tmp
RUN bash /tmp/init-mysql.sh

#installation de wordpress
COPY ./srcs/wordpress.tar.gz /var/www/html/
RUN tar xzf /var/www/html/wordpress.tar.gz && rm /var/www/html/wordpress.tar.gz
RUN mv wordpress /var/www/html
COPY ./srcs/wp-config.php /var/www/html/wordpress
#ajout du dossier theme new-blog
COPY ./srcs/new-blog /var/www/html/wordpress/wp-content/themes/new-blog

#donner les droits à nginx
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

#installation de phpMyAdmin
COPY ./srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www/html/
RUN tar xzf /var/www/html/phpMyAdmin-4.9.5-all-languages.tar.gz && rm /var/www/html/phpMyAdmin-4.9.5-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.5-all-languages /var/www/html/phpmyadmin
COPY ./srcs/phpmyadmin.inc.php /var/www/html/phpmyadmin

#RAJOUTER LA GESTION DU SSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=obaribau' -keyout /etc/ssl/monsite.key -out /etc/ssl/monsite.pem

#lancement des services
COPY ./srcs/start.sh ./
CMD bash start.sh
