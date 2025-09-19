## FILE_METADATA

### Conceito: FILE_METADATA

Responsável por manter metadados sobre um arquivo mantido no ecossistema `DATOFERUM`, cuja a máquina de stado pode estar representada por um dos valores possíveis destacado na coluna `status` e devidamente registrado o momento do status na coluna `processedAt`. Uma stored procedure devera ser usada para alimentar a coluna `lifeCicleHist` com entradas de texto no formado Markdown, para facilitar a leitura por humanos e que seja fácil o `parser` no caso de monitoração inter sistemas, ou com o uso de classes especializadas para uso com o monitorador internno `actuator`. 2K a mais de dados, por tupla, é menor que toda a complexidade na aplicação para gerienciar isso em  tuplas e entidades separadas. Considere ainda o fato de que esta coluna `lifeCicleHist` e `processedAt` só devem ser processadas no ambito do SGBD e nunca trafegar entre Servidor Web e o Cliente. Por esta e outras razões jamais usar `select * from file_metadata` na aplicação.

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
                                      'PROCESSED'         , 'AVAILABLE'            ,
                                      'AVAILABLE_BY_SHERE', 'AVAILABLE_BY_LINK_REF',
                                      'JOB_ATACHED'       , 'JOB_PROCESSING'       , 
                                      'JOB_REFUSED'       , 'JOB_SUCESS'           ,
                                      'JOB_ERROR'         , 'JOB_CANCELED'         ,                                      
                                      'OFF_LINE'          , 'MARK_TO_PURGE'        ,
                                      'PURGED'            , 'HISTORY'              ,
                                      'UNKNOW'),
    lifeCicleHist     TEXT,
    FOREIGN KEY (userId) REFERENCES users (id) ON DELETE SET NULL
);
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
                                       
