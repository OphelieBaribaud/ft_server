FROM debian:buster

#installation de nginx
RUN apt-get update
RUN apt-get install -y apt-utils nginx
RUN rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY ./srcs/default /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

#installation de mySQL && téléchargement de PHP
RUN apt-get install -y default-mysql-server default-mysql-client
RUN apt-get install -y php-mysql php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-cli php-ldap php-zip php-curl
#creation de la database et d'un user dans MYSQL à l'aide d'un script
COPY ./srcs/init-mysql.sh /tmp
RUN bash /tmp/init-mysql.sh

#WORKDIR /var/www/html -> modifier les redirection ci-dessous
#supprimer index.nginx-debian.html

#installation de wordpress
COPY ./srcs/wordpress.tar.gz /var/www/html/
RUN tar xzf /var/www/html/wordpress.tar.gz && rm /var/www/html/wordpress.tar.gz
RUN mv wordpress /var/www/html
RUN chmod 755 -R /var/www/html/
COPY ./srcs/wp-config.php /var/www/html/wordpress

#installation de phpMyAdmin
COPY ./srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www/html/
RUN tar xzf /var/www/html/phpMyAdmin-4.9.5-all-languages.tar.gz && rm /var/www/html/phpMyAdmin-4.9.5-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.5-all-languages /var/www/html/phpmyadmin
COPY ./srcs/phpmyadmin.inc.php /var/www/html/phpmyadmin

#RAJOUTER LA GESTION DU SSL
#essayer de mettre le nom du serveur dans l'url ?
#est-ce qu'il faut que la page d'accueil soit wordpress ou l'index, si on met 127.0.0.1:8080

#revoir comment lancer ces commandes au lancement du conteneur
CMD service nginx start 
CMD service php7.3-fpm start
CMD service mysql start
