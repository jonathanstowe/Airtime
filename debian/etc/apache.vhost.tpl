<VirtualHost *:80>
      ServerName __SERVER_NAME__
      #ServerAlias www.example.com

      ServerAdmin __SERVER_ADMIN__

      DocumentRoot /usr/local/share/airtime/public
      DirectoryIndex index.php

      SetEnv APPLICATION_ENV "production"

      <Directory /usr/local/share/airtime/public>
              Options -Indexes FollowSymLinks MultiViews
              AllowOverride All
              Order allow,deny
              Allow from all
      </Directory>
</VirtualHost> 
