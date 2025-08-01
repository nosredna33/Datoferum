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

