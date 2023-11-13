sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
libgdbm-dev libnss3-dev libedit-dev libc6-dev
wget https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz
tar -xzf Python-3.6.15.tgz
cd Python-3.6.15
./configure --enable-optimizations  -with-lto  --with-pydebug
make -j 8  # adjust for number of your CPU cores
sudo make altinstall
python3.6 -V
cd ..

echo "virtualenv can be installed by: pip3 install virtualenv"
rm -rf venv
virtualenv venv --python=python3.6
echo "Active the virtual env: source venv/bin/activate"
source venv/bin/activate
pip install tox
python3 --version
pip --version;\
tox --version;\
cd fabric-sdk-py
pip install -r requirements.txt;\
pip  install -r requirements-test.txt
python3 -m pip install --no-build-isolation pyyaml==5.4.1
echo "Deactive when done: deactivate"

python3 setup.py install
pip install --upgrade "protobuf<=3.20.3"

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
tox -e py3 -- test/integration/e2e_test.py # Run specified test case
deactivate
