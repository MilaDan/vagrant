# #/usr/bin/bash
useradd sonar
yum install unzip wget java-11-openjdk-devel -y
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.3.0.51899.zip
unzip sonarqube-9.3.0.51899.zip -d /opt/
chown -R sonar:sonar /opt/sonarqube-9.3.0.51899
touch /etc/systemd/system/sonar.service
echo > /etc/systemd/system/sonar.service
cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube-9.3.0.51899/bin/linux-x86-64/sonar.sh stopj
User=sonar
Group=sonar
Restart=always
[Install]
WantedBy=multi-user.target
EOT
service sonar start

 #instalar sonar scanner
 wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip
 unzip sonar-scanner-cli-4.7.0.2747-linux.zip -d /opt/
 chown -R sonar:sonar /opt/sonar-scanner-4.7.0.2747-linux
 echo 'export PATH=$PATH:/opt/sonar-scanner-4.7.0.2747-linux/bin' | sudo tee -a /etc/profile
 curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
 sudo yum install nodejs -y
 
#2166f592b9b96ce8a878e57b4f98ad5b0c18f442
