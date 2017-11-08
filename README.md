# Using PK Drupal Vagrant based development Environment

1. Please make sure that you have installed git, Vagrant, VirtualBox and PHP Composer
2. Clone the repository by running the command
    ```
    git clone https://github.com/forethoughtde/drupal-vagrant-development-environment.git
    ```
3. Change the directory to the clone directory
4. Please check the following lines in Vagrantfile for port numbers; Make sure that the port numbers do not collide with other projects
   ```
    config.vm.network :forwarded_port, host: 22321, guest: 443
    config.vm.network :forwarded_port, host: 22322, guest: 3306
   ```
5. Run the command if you have installed composer globally
    ```
    composer install
    ```
    If you have composer.phar file locally in your project then run the following command
    ```
    php composer.phar install
    ```
    composer will install all the required modules and will take sometime depends upon your network connection
6. If all the above steps went correctly without any errors, you can now run the command
    ```
    vagrant up
    ```
7. After the above command commands you can go to the browser and type https://localhost:<port number> and complete Drupal installation process.
8. In order to complete the installation process, you would need database name. So take database port number from Vagrant and go to your prefered database management application like SequelPro
    to create the database. 
9. That's it all.

Thanks for using PK Drupal Vagrant based development Environment
       

