# ft_server

Mise en place dans un seul docker d'un serveur web en utilisant :

-   Debian Buster,
-   Nginx,
-   Wordpress,
-   MySQL,
-   phpMyAdmin,
-   protocole SSL avec certificat autosigné.

<code>docker build -t monsite .</code>

<code>docker run -it -p 443:443 -p 8080:80 monsite</code>

![alt text](http://g.recordit.co/TteImByZj2.gif)

Projet réalisé dans le cadre de l'École 42. Note 100/100.
