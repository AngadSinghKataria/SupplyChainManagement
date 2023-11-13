sudo apt-get install git curl docker-compose -y

# Make sure the Docker daemon is running.
sudo systemctl start docker

# Add your user to the Docker group.
sudo usermod -a -G docker ${USER}

# Check version numbers  
docker --version
docker-compose --version

# Optional: If you want the Docker daemon to start when the system starts, use the following:
sudo systemctl enable docker

wget https://dl.google.com/go/go1.21.3.linux-amd64.tar.gz
sudo tar -xvf go1.21.3.linux-amd64.tar.gz
sudo mv go /usr/local

cd /etc

echo "GOROOT=/usr/local/go" >> profile
echo "GOPATH=$HOME/go" >> profile
echo "PATH=$PATH:/usr/local/go/bin" >> profile
cd -
pwd


cd fabric-samples
cd bin
echo "PATH=$PATH:/mnt/c/Users/$USER/OneDrive/Documents/GitHub/SupplyChainManagement/fabric-samples/bin" >> ~./

cd ..
cd ..

sudo apt-get install jq

# mkdir -p $HOME/go/src/github.com/isha1056
# cd $HOME/go/src/github.com/isha1056

curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh
./install-fabric.sh -h
./install-fabric.sh docker samples binary
./install-fabric.sh --fabric-version 2.5.0 binary
