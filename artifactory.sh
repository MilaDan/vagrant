# Install Jfrog Artifactory
#


# Installing Java
echo "Installing Java"
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install oracle-java8-installer -y


# Installing Nginx
echo "Installing NGINX"
wget -c -O- http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" | sudo tee -a /etc/apt/sources.list.d/nginx.list > /dev/null
sudo apt-get update
sudo apt-get -y install nginx

# Configure Nginx reverse proxy
echo "Configuring Nginx reverse proxy"
sudo mkdir /etc/nginx/sites-available
sudo mkdir /etc/nginx/sites-enabled

#Copy nginx configuration files
cp /vagrant/conf/nginx.conf /etc/nginx/
cp /vagrant/conf/artifactory.conf /etc/nginx/sites-available
sudo rm -f /etc/nginx/conf.d/*
sudo ln -sf /etc/nginx/sites-available/artifactory.conf /etc/nginx/sites-enabled/artifactory.conf
sudo service nginx restart



# Installing Jfrog Artifactory
echo "Installing Artifactory"
wget -c -O- "https://bintray.com/user/downloadSubjectPublicKey?username=jfrog" | sudo apt-key add -
echo "deb https://jfrog.bintray.com/artifactory-pro-debs trusty main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y jfrog-artifactory-pro

#End Script
