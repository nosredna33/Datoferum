# Datoferum
> *`Datoferum`*: Gubernatio Totalis Vitae Documentorum in Nube
> (Sistema Portador de Dados com Gestão Integral do Ciclo de Vida de Arquivos na Nuvem)

## Conceito

> O equivalente ao termo **aquífero**, relativo aos dados é **Datoferum**

> "Per APIs, datos, per `Datoferum`, lacus datorum!"
> (Por meio de APIs, dados, por meio de `Datoferum`, lagos de dados!)

## O "**`Datoferum`**" é...

Um sistema projetado para controlar todo o ciclo de vida dos arquivos — desde a captura pós-produção até o expurgo controlado — seguindo princípios Cloud Native e Independent Movement, com rastreabilidade, totalmente baseados em sistemas abertos. Que pode ser útil para grandes ou intensas movimentaçãoes de dados segmentadas, incrementais ou comletos também, com interface web responsiva e elegante para que usuários possam acompanhar os processos envolvendo os dados da crição / Extração ào Expurgo controlado, sinalizado através de processos exôgenos por API.

### A Sigla
**`DTRM`** foi a melhor escolha de abreviação para **`Datoferum`**, pois, soa moderno, forte e decisivo, como "determine" do inglês — realmente transmite a ideia de um solução que traz determinação no controle do ciclo de vida do dado, durante a inrteroperabilidade para geração de informações.

### A Logo

<img src="https://github.com/nosredna33/Datoferum/blob/12b6cc739335af7f1a5993f9ded423e91cd24a0f/logo-fnd-branco.png?raw=true" alt="Logo do Projeto Datoferum" style="width: 50%; height: auto; float: left; margin-right: 15px; margin-bottom: 10px;">

**Pode ser usado com o que**: arquivo a ser manuseado sejam eles: Logs, coleta de Streams para distribuioção, Grandes cargas massivas de dados, despejos controlados em Data-lakes, grandes extrações para conciliação e/ou publicações de dados, recepção de grandes volumes de IOT, despejos de billing, imagens de backups e once-data-pick-and-go distribuição de mídias e conteúdos pagos.

## O que o "**`Datoferum`**" NÃO é 
O `Datoferum` não é Webdav, NFS, DropBox, Google Drive, SAMBA/CIFES, SFTP, S3 ou qualquer outra Boacumba para persistir dados com seu protocolo proprietário, mas pode ser gateway para persistir ou coletar dados em qualquer uma destas tecnologias proprietárias.

------

# Componentes open que juntos fazem o que o `Datoferum` faz sozinho:
- **HDFS**: Armazenamento e processamento distribuído de grandes volumes de dados.
- **HUE**: Interface amigável para gerenciamento e consulta dos dados.
- **MariaDB**: Banco de dados relacional para metadados e controle transacional.
- **Solr**: Busca avançada e indexação de documentos.
- **Keycloak**: Autenticação e autorização segura (IAM).
- **Logstash**: Usado para padrozinar os logs dos componentes da pilha de software e os persistir em local seguro, inalterável e pesquisável (LGPD)
- **Kafka**: Responsável por gestão de filas em processos de sincronização de streams e serialização de processos.
- **Hadoop**:

------

# Funcionalidades:
- **Cloud Native**: Arquitetura escalável, compatível com Kubernetes e microsserviços.
- **Operável por Web Browser**: Permitindo aos usuários prezos em jaulas de segurança (acesso resteito a porta 443, com protocolo SSL/TLS) mandar e receber dados de forma segura e **NÃO** anônima.
- **Permite automação**: Uso indiscriminado do comando de linha `curl`, pois está pronto, portável para todas as plataformas e fala praticamente todos oso protocolos de comunicação com tecnologias de mercado.

------

# Fluxo do Ciclo de Vida:
- **Captura**: Ingestão de arquivos após produção (ex.: dados, vídeos, logs, imagens).
- **Classificação**: Organização automática por metadados (Solr + MariaDB).
- **Armazenamento**: Distribuição no HDFS com políticas de redundância.
- **Acesso**: Consulta via HUE e APIs, com segurança via Keycloak.
- **Expurgo**: Exclusão programada ou sob de**: manda, com auditoria.

------

# Diferenciais:
- **Autonomia**: Elimina dependência de soluções proprietárias (Independent Movement).
- **Rastreabilidade**: Logs detalhados do ciclo de vida de cada arquivo.
- **Otimização**: Hadoop e Solr garantem performance mesmo com petabytes de dados.

------

# Exemplos de Uso:
1. **"Um estúdio de streaming usa o `Datoferum` para gerenciar entregas de vídeos produzidos (10 TB) aos seu cliente"** — da ingestão de partes do vídeo e arquivos de audio à pós-edição os gigantescos arquivos intermediários são mantidos e com acesso controlado até a exclusão após 5 anos, cumprindo LGPD.

2. **"Recepção de dados extraídos por agências reguladoras ou provedores de facilities (Água/Luz/Gás/Telecom)"** - recepção de dados estruturados ou não para cargas em banco de dados assincronos (Loading do ETL) ou até mesmo processamento de jobs de automação para ingestão transacional ou massíva de dados;

3. **"Hub de conciliação de grandes volumes de transações de Logs, Billing ou Aquiriment"** - **_Vide item 2_**!

4. **"Propagação de grande volumes de dados de streams entre POPs regionais"** - divulgação de evento na Web por stream com balanceamento de carga entre os Pontos Operacionais de Presença regionais das  empresas de Telecom.

5. **Movimentação Massiva de Dados entre datacenters"** - Backup ou mudanças de datacenters a quente!

------

# NÃO SÃO Exemplos de Uso:
1. **"ETL, ELT ou qualquer anagrama formado das letras desse processo"** - Mas, podemos manter uma máquina de estado das etapas do processo exôgenos indicando ao usuário o estado dos dados mantidos, de forma transiente no `Datoferum.

2. **"Solução de Back-Up"** - Não é para isso, existem soluções mais baratas e eficiente para este propósito.

3. **"Qualquer tipo de manipulação no dados!"** - Em total respeito à LGPD ou normas internacionais de controle de acesso aos dados.

------

# Simplificando o nosso conceito por analogia
Somos uma solução (um ecossistema) especializado em **`delivery da dados massivos ou numerosos`** , coletamos e entregamos de dados, como se fossemos moto-boys de bytes. Pegamos envelopes fechados de dados, mediante contrato e termos de conduta para retenção, e os entregamos a quem, e somente a quem, é o destinatário. Garantimos a entrega, a inviolabilidade dos dados e o acesso não autorizado aos mesmos, independentemente do tipo de **doca para recepção de arquivos** (protocolo de transferência ou produto usado na coleta e na recepção como: _Webdav, NFS, DropBox, Google Drive, SAMBA/CIFES, SFTP, S3 ou qualquer outra Boacumba para persistir dados_ ).

------

# FAQ
1. **"Se o meu dado foi gerado na origem com CHARSET diferente do esperado, vocês os transliteram para carga em nosso ambiente"**? **Não**! Não adcionamos óregano às pizzas, no meio do caminho. Pois isso violaria os termos da LGPD, entre nós e os usuários da plataforma.

2. **"O que acontece se o arquivo mantido na área intermediária da `Datoferum` extrapolar o tempo de guarda previsto para retenção contratado"**? **LIXO** - Sem chances de recuperação, pois não somos ferramentas de backup, existem ferramentas para isso mais eficientes e mais baratas.

3. **"Eu tenho um mainframe que coleta bilhões de transações de logs no ADABAS e preciso fazer ETL com os Logs, porém, a latência da nuvem não cabe na minha janela de ETL, o que fazer"**? - Compre uma super máquina com SSD NVMe2, e outras mágicas de interconexão entre eles, ou pool de máquinas, instale o `Datoferum` em modo cluster on-premises, desative a indexação dos manifestos dos arquivos e reescreva os jobs do processo de ETL para executar em paralelo.

4. **"Eu tenho um datacenter no centro de São Paulo com mainframes usando storages Symmetrics e quero mover meus 21 PB para o novo datacenter em Campinas para Hardwares novos, posso usar o `Datoferum`"**? **DEVE**! Além de contratar os engenheiros desta solução para te ajudar no processo, que não é nada trivial.

------

# Documentação técnica 

## Árvore do projeto Datoferum Enterprise
<pre>
datoferum/
├── docker/
│   ├── hdfs/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── hadoop/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── mariadb/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── solr/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── kafka/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── hue/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── keycloak/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   ├── logstash/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
├── scripts/
│   ├── start-datoferum.sh
├── .env
├── README.md
</pre>
