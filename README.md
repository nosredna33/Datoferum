# Datoferum
*`Datoferum`*: Gubernatio Totalis Vitae Documentorum in Nube
(Sistema Portador de Dados com Gestão Integral do Ciclo de Vida de Arquivos na Nuvem)



# Conceito
"Per APIs, datos, per "`Datoferum`", lacus datorum!"
(Por meio de APIs, dados, por meio de `Datoferum`, lagos de dados!)

## O que é o "`Datoferum`"
Um sistema projetado para controlar todo o ciclo de vida dos arquivos — desde a captura pós-produção até o expurgo controlado — seguindo princípios Cloud Native e Independent Movement, com rastreabilidade, totalmente baseados em sistemas abertos. Que pode ser útil para grandes ou intensas movimentaçãoes de dados segmentadas, incrementais ou comletos também, com interface web responsiva e elegante para que usuários possam acompanhar os processos envolvendo os dados da crição / Extração ào Expurgo controlado, sinalizado através de processos exôgenos por API.

*Pode ser usado com que*: arquivo a ser manuseado sejam eles: Logs, coleta de Streams para distribuioção, Grandes cargas massivas de dados, despejos controlados em Data-lakes, grandes extrações para conciliação e/ou publicações de dados, recepção de grandes volumes de IOT, despejos de billing, imagens de backups e once-data-pick-and-go distribuição de mídias e conteúdos pagos.

## O que NÃO é o "`Datoferum`"
O `Datoferum` não é Webdav, NFS, DropBox, Google Drive, SAMBA/CIFES, SFTP, S3 ou qualquer outra Boacumba para persistir dados com seu protocolo proprietário, mas pode ser gateway para persistir ou coletar dados em qualquer uma destas tecnologias proprietárias.

# Componentes e Funcionalidades:
- *HDFS + Hadoop*: Armazenamento e processamento distribuído de grandes volumes de dados.
- *HUE*: Interface amigável para gerenciamento e consulta dos dados.
- *MariaDB*: Banco de dados relacional para metadados e controle transacional.
- *Solr*: Busca avançada e indexação de documentos.
- *Keycloak*: Autenticação e autorização segura (IAM).
- *Cloud Native*: Arquitetura escalável, compatível com Kubernetes e microsserviços.
- *Command CLI*: Uso indiscriminado do `curl`, pois está pronto, portável para todas as plataformas e fala praticamente todos oso protocolos de comunicação com tecnologias de mercado.


# Fluxo do Ciclo de Vida:
Captura: Ingestão de arquivos após produção (ex.: vídeos, logs, imagens).

Classificação: Organização automática por metadados (Solr + MariaDB).

Armazenamento: Distribuição no HDFS com políticas de redundância.

Acesso: Consulta via HUE e APIs, com segurança via Keycloak.

Expurgo: Exclusão programada ou sob demanda, com auditoria.

Diferenciais:
Autonomia: Elimina dependência de soluções proprietárias (Independent Movement).

Rastreabilidade: Logs detalhados do ciclo de vida de cada arquivo.

Otimização: Hadoop e Solr garantem performance mesmo com petabytes de dados.

Exemplo de Uso:
*"Um estúdio de streaming usa o Datofer para gerenciar 10PB de vídeos — da ingestão pós-edição até a exclusão após 5 anos, cumprindo LGPD."*
