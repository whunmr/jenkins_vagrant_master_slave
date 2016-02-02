sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y --force-yes jenkins git sshpass
sudo sh -c 'echo "192.168.100.21 jenkins.local jenkins" >> /etc/hosts'
sudo sh -c 'echo "192.168.100.11 jenkinslave.local jenkinslave"  >> /etc/hosts'
sudo apt-get autoremove -y
sudo -u jenkins "echo -e  'y\n'|ssh-keygen -q -t rsa -N '' -f /var/lib/jenkins/.ssh/id_rsa"
sshpass -p 'vagrant' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "vagrant@jenkinslave.local" 'echo "jenkins:jenkins" | chpasswd'
cat /var/lib/jenkins/.ssh/id_rsa| sshpass -p 'jenkins' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "jenkins@jenkinslave.local"  "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
sudo service jenkins start
