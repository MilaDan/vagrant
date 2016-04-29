#!/bin/bash

do_jenkins_check() {
	printf "Waiting for Jenkins to come up."

	sleep_amount_seconds=1
	max_checks=30
	checks=0
	reached_jenkins=0
	status_code=000

	while [ $reached_jenkins -eq 0 -a $checks -lt $max_checks ]; do 
		next_status_code=$(curl -I --output /dev/null --silent --head --write-out "%{http_code}" http://localhost:8080 | head -n 1 | cut -d$' ' -f2)

		if [ ! $next_status_code -eq $status_code ]; then
			printf "Service changed from a %s response to a %s response." $status_code $next_status_code
		fi

		status_code=$next_status_code

		checks=$[$checks+1]
		if [ $status_code -eq 403 ]; then
			reached_jenkins=1
			break
		fi

		sleep $sleep_amount_seconds
	done

	if [ $reached_jenkins -eq 0 ]; then
		printf "Failed to see jenkins come up within %d seconds. Quitting..." $[$sleep_amount_seconds * $max_checks]
		exit 1
	fi
	echo "Hooray! It's up!"
}


# TIMEZONE
# Credit: http://www.thegeekstuff.com/2010/09/change-timezone-in-linux/
echo "Setting timezone to America/Central"
rm /etc/localtime
ln -s /usr/share/zoneinfo/US/Central /etc/localtime

# INSTALL JENKINS
sudo apt-get -y remove jenkins
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update

# Have to do this twice-- the first time it fails to start the jenkins application.
sudo apt-get -y install jenkins
sudo apt-get -y install jenkins

echo "Creating bash aliases..."
if [ ! -f '/home/vagrant/.bash_aliases' ]; then 
	touch '/home/vagrant/.bash_aliases'
fi

echo "Attaching alias script to .bashrc..."
if [ ! -f '/home/vagrant/.bashrc' ]; then
        touch '/home/vagrant/.bashrc'
fi

echo "Appending aliases to bash aliases"
printf "\n\n. /home/vagrant/.bash_aliases" >> /home/vagrant/.bashrc

do_jenkins_check

printf "Setting up Jenkins CLI\n"
wget --quiet http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar

printf "\n export JENKINS_URL=http://localhost:8080/" >> /home/vagrant/.bashrc
printf "\n alias jnkns=\"java -jar /home/vagrant/jenkins-cli.jar\"" >> /home/vagrant/.bashrc

export JENKINS_URL=http://localhost:8080

echo "Installing build-timeout plugin for Jenkins."
java -jar /home/vagrant/jenkins-cli.jar install-plugin build-timeout > /dev/null
java -jar /home/vagrant/jenkins-cli.jar install-plugin job-dsl > /dev/null
java -jar /home/vagrant/jenkins-cli.jar restart > /dev/null

echo "Restarted Jenkins after installing plugins."
do_jenkins_check

jenkins_password=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Browse to https://localhost:8100 and use this password for initial setup: "$jenkins_password

printf "Setup complete!\n"
