# pre-install.sh
# Descrição: usado oara preparar o ambiente virgem para a instalação do Datoferum
# Histórico de atualização 
# 31/07/2025 - Criação do script
# 01/08/2025 - Adição de components ao S.O

sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker ec2-user

# Instala Hadoop 
dnf install -y openjdk-11-jdk wget
wget https://hadoop.apache.org/releases/hadoop-3.3.6.tar.gz
tar -xzf hadoop-3.3.6.tar.gz -C /opt
mv /opt/hadoop-3.3.6 /opt/hadoop

# Instala Solr
wget https://archive.apache.org/dist/solr/solr-9.3.0/solr-9.3.0.tgz
tar -xzf solr-9.3.0.tgz -C /opt
mv /opt/solr-9.3.0 /opt/solr

# Instala Kafka
wget https://kafka.apache.org/releases/3.7.0/kafka_2.13-3.7.0.tgz
tar -xzf kafka_2.13-3.7.0.tgz -C /opt && \
mv /opt/kafka_2.13-3.7.0 /opt/kafka

