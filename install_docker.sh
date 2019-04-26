# Install Docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Set Vagrant User to Docker 
sudo groupadd docker
sudo usermod -aG docker vagrant

# Copy system.d settings.
mkdir -p /etc/systemd/system/docker.service.d
cp /vagrant/docker-service.d/* /etc/systemd/system/docker.service.d/

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl start docker

# Enable Ports for Firewalls
sudo firewall-cmd --permanent --add-port=2375/tcp
sudo firewall-cmd --permanent --add-port=2375/upd
sudo firewall-cmd --permanent --add-port=2375/udp
sudo firewall-cmd --permanent --add-port=2376/udp
sudo firewall-cmd --permanent --add-port=2375/udp
sudo firewall-cmd --permanent --add-port=2375/tcp
sudo firewall-cmd --permanent --add-port=2376/tcp
sudo firewall-cmd --reload

# Install Docker-Compose to run
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose