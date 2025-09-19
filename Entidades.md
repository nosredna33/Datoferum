## FILE_METADATA

### Conceito: FILE_METADATA

Responsável por manter metadados sobre um arquivo mantido no ecossistema `DATOFERUM`, cuja a máquina de stado pode estar representada por um dos valores possíveis destacado na coluna `status` e devidamente registrado o momento do status na coluna `processedAt`. Uma stored procedure devera ser usada para alimentar a coluna `lifeCicleHist` com entradas de texto no formado Markdown, para facilitar a leitura por humanos e que seja fácil o `parser` no caso de monitoração inter sistemas, ou com o uso de classes especializadas para uso com o monitorador internno `actuator`. 2K a mais de dados, por tupla, é menor que toda a complexidade na aplicação para gerienciar isso em  tuplas e entidades separadas. Considere ainda o fato de que esta coluna `lifeCicleHist` e `processedAt` só devem ser processadas no ambito do SGBD e nunca trafegar entre Servidor Web e o Cliente. Por esta e outras razões jamais usar `select * from file_metadata` na aplicação.

#### Descrição dos Campos

Eis um dicionário de dados resumido, cuja a representação física deverá ser totalmente equivalente na implementaão fíca, descrita pelo comando **`DDL SQL`** definido lo a seguir.

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| id | INTEGER | Sim | Chave primária autoincrementada |
| filename | VARCHAR(255) | Sim | Nome do arquivo no sistema |
| originalFilename | VARCHAR(255) | Sim | Nome original do arquivo |
| fileType | VARCHAR(100) | Sim | Tipo/categoria do arquivo |
| fileSize | BIGINT | Sim | Tamanho do arquivo em bytes |
| fileExtension | VARCHAR(50) | Não | Extensão do arquivo |
| uploadDir | VARCHAR(500) | Sim | Diretório onde o arquivo foi armazenado |
| uploadedAt | TIMESTAMP | Sim | Data/hora do upload (default: CURRENT_TIMESTAMP) |
| virusScanPassed | BOOLEAN | Não | Indicador se passou na verificação de vírus |
| virusDetected | BOOLEAN | Não | Indicador se vírus foi detectado |
| description | VARCHAR(1000) | Não | Descrição opcional do arquivo |
| tags | VARCHAR(500) | Não | Tags para categorização |
| mimeType | VARCHAR(500) | Não | Tipo MIME do arquivo |
| checksum | VARCHAR(255) | Não | Checksum para verificação de integridade |
| contentText | TEXT | Não | Texto extraído do conteúdo (para indexação) |
| contentExtracted | BOOLEAN | Não | Indicador se o conteúdo foi extraído |
| metadata | TEXT | Não | Metadados adicionais em formato JSON |
| isIndexed | BOOLEAN | Não | Indicador se o arquivo foi indexado |
| isPublic | BOOLEAN | Não | Indicador se o arquivo é público |
| userId | INTEGER | Não | ID do usuário que fez o upload |
| processedAt | TIMESTAMP | Não | Data/hora do processamento |
| status | VARCHAR(50) | Sim | Estado atual do arquivo no sistema |
| lifeCicleHist | TEXT | Não | Histórico de estados do arquivo |

#### Estrutura de dados:

```sql
CREATE TABLE IF NOT EXISTS file_metadata (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    filename          VARCHAR(255) NOT NULL,
    originalFilename  VARCHAR(255) NOT NULL,
    fileType          VARCHAR(100) NOT NULL,
    fileSize          BIGINT NOT NULL,
    fileExtension     VARCHAR(50),
    uploadDir         VARCHAR(500) NOT NULL,
    uploadedAt        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    virusScanPassed   boolean DEFAULT false,
    virusDetected     boolean DEFAULT false,
    description       VARCHAR(1000),
    tags              VARCHAR(500),
    mimeType          VARCHAR(500),
    checksum          VARCHAR(255),
    contentText       TEXT,
    contentExtracted  boolean DEFAULT false,
    metadata          TEXT,
    isIndexed         boolean DEFAULT false,
    isPublic          boolean DEFAULT false,
    userId            INTEGER,
    processedAt       TIMESTAMP,
    status            VARCHAR(50) NOT NULL 
                      CHECK (name IN ('UNAVAILEBLE'       , 'UPLOADED'             , 
                                      'PROCESSING'        , 'VIRUS_SCANING'        ,
                                      'VIRUS_DETECTED'    , 'GETING_METADATA'      ,
                                      'INDEXING'          , 'INDEXED'              ,
                                      'PROCESSED'         , 'AVAILABLE'            ,
                                      'AVAILABLE_BY_SHERE', 'AVAILABLE_BY_LINK_REF',
                                      'JOB_ATACHED'       , 'JOB_PROCESSING'       , 
                                      'JOB_REFUSED'       , 'JOB_SUCCESS'          ,
                                      'JOB_ERROR'         , 'JOB_CANCELLED'        ,                                      
                                      'OFF_LINE'          , 'MARK_TO_PURGE'        ,
                                      'PURGED'            , 'HISTORY'              ,
                                      'UNKNOW'),
    lifeCicleHist     TEXT,
    FOREIGN KEY (userId) REFERENCES users (id) ON DELETE SET NULL
);
```

#### Índices Recomendados

```sql
-- Índices para melhorar performance em consultas frequentes
CREATE INDEX IF NOT EXISTS idx_file_metadata_status ON file_metadata(status);
CREATE INDEX IF NOT EXISTS idx_file_metadata_user_id ON file_metadata(userId);
CREATE INDEX IF NOT EXISTS idx_file_metadata_uploaded_at ON file_metadata(uploadedAt);
CREATE INDEX IF NOT EXISTS idx_file_metadata_checksum ON file_metadata(checksum);
CREATE INDEX IF NOT EXISTS idx_file_metadata_file_type ON file_metadata(fileType);
CREATE INDEX IF NOT EXISTS idx_file_metadata_is_public ON file_metadata(isPublic);
```


#### Exemplo de dados na coluna lifeCicleHist
| Quem (id usuário) | STATUS           | Quando (yyyy-mm-ddThh24:mi:ss.ccc) | Mensagem (JSON format)  |
| ----------------- | ---------------- | ---------------------------------- | ----------------------  |
| 1 (Admin User)    | UNAVAILEBLE      | 2025-09-05T03:45:36.345            | {"messge": "Criado"}    |
| 1 (Admin User)    | UPLOADED         | 2025-09-05T03:56:36.765            | {"messge": "Carregado"} | 
| 0 (System User)   | PROCESSING       | 2025-09-05T03:57:00.165            | {"messge": "Processando"} |
| 0 (System User)   | VIRUS_SCANING    | 2025-09-05T03:58:00.265            | {"messge": "Procurando Vírus"} |
| 0 (System User)   | VIRUS_DETECTED   | 2025-09-05T03:58:00.165            | {"messge": "Vírus encontrado"} |
| 0 (System User)   | OFF_LINE         | 2025-09-05T03:59:46.965            | {"messge": "Desativado por detecção de vírus"} |
| 1 (Admin User)    | MARK_TO_PURGE    | 2025-09-07T13:00:36.765            | {"messge": "Marcado para excluão"} |
| 0 (System User)   | PURGED           | 2025-09-07T13:00:36.765            | {"messge": "Eliminado"} |     
| 0 (System User)   | HISTORY          | 2025-09-07T13:00:36.765            | {"messge": "Metadados para histórico"} |     
                                       
## Análise da Estrutura

### Pontos Fortes

- ✅ **Campos essenciais** para metadados de arquivos
- ✅ **Controle de estado** com valores específicos para rastrear o ciclo de vida
- ✅ **Campos de segurança** (verificação de vírus)
- ✅ **Rastreabilidade** com datas e usuário
- ✅ **Suporte a interoperabilidade** (checksum, mimeType)
- ✅ **Flexibilidade** com campos para metadados adicionais e texto extraído

### Melhorias Sugeridas

1. **Correção na constraint CHECK**: A constraint referencia "name" mas deveria ser "status"
2. **Índices estratégicos** para melhor performance em operações de leitura
3. **Normalização** dos campos de status poderia ser considerada para cenários complexos
4. **Campo de origem** para identificar o sistema de origem em cenários de interoperabilidade

## Estados Possíveis (Campo status)

| Estado | Descrição |
|--------|-----------|
| UPLOADED | Arquivo foi enviado mas ainda não processado |
| PROCESSING | Em processamento inicial |
| VIRUS_SCANING | Em verificação de vírus |
| AVAILABLE | Disponível para uso |
| JOB_PROCESSING | Associado a um job em processamento |
| JOB_SUCESS | Processamento por job concluído com sucesso |
| MARK_TO_PURGE | Marcado para remoção |
| PURGED | Removido do sistema |

## Exemplos de Uso

### Inserção de Novo Arquivo
```sql
INSERT INTO file_metadata (
    filename, originalFilename, fileType, fileSize, 
    uploadDir, userId, status
) VALUES (
    'relatorio_202310.pdf', 'Relatório Financeiro Outubro.pdf', 
    'PDF', 2048576, '/uploads/2023/10', 123, 'UPLOADED'
);
```

### Atualização de Status após Processamento
```sql
UPDATE file_metadata 
SET status = 'AVAILABLE', 
    processedAt = CURRENT_TIMESTAMP,
    virusScanPassed = true,
    isIndexed = true
WHERE id = 45;
```

### Consulta de Arquivos Públicos
```sql
SELECT id, filename, fileType, fileSize, uploadedAt, description
FROM file_metadata
WHERE isPublic = true
  AND status = 'AVAILABLE'
ORDER BY uploadedAt DESC;
```

### Busca por Checksum (verificação de duplicatas)
```sql
SELECT id, filename, fileSize, uploadedAt
FROM file_metadata
WHERE checksum = 'a1b2c3d4e5f67890123456789abcdef012345678'
  AND status != 'PURGED';
```

## Considerações para Dados Massivos

1. **Particionamento**: Considere particionar a tabela por data (`uploadedAt`) para grandes volumes
2. **Arquivo de histórico**: Mova registros com status `PURGED` ou `HISTORY` para tabela de histórico
3. **Compactação**: Considere compactar o conteúdo dos campos `contentText` e `metadata`
4. **Limpeza regular**: Implemente processo para remover registros antigos não necessários

## Notas de Implementação

- A tabela foi projetada para SQLite, mas é facilmente adaptável para outros SGBDs
- Para sistemas de alta concorrência, considere usar `DATETIME` com precisão de milissegundos
- O campo `checksum` deve usar algoritmo consistente (ex: SHA-256) em toda a aplicação
- O campo `metadata` pode armazenar JSON com metadados específicos de diferentes tipos de arquivo

Esta estrutura fornece uma base sólida para um ecossistema de interoperabilidade com troca de dados massivos, permitindo rastreamento completo do ciclo de vida dos arquivos e suporte a diversos cenários de uso.
