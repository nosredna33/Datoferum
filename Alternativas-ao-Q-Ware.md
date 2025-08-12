# Alternativas simples ao Q-Ware

## O problema
Existe uma solução simples, estilo webdav, porém, totalmnte segura, open source, operavel somente via browser ou curl/wget, sobre HTTPS?

## A resposta:
**Sim** — existem soluções estilo WebDAV, mas mais seguras, open source, e que podem ser usadas apenas via navegador ou curl/wget sobre HTTPS, sem depender de cliente dedicado.
Basicamente, você está procurando algo que ofereça:

- Acesso remoto a arquivos
- Interface web simples + API HTTP/HTTPS
- Autenticação segura
- Criptografia em trânsito (TLS/HTTPS)
- Compatível com curl/wget
- Open source

## Aqui vão algumas opções bem conhecidas:

1. **Nextcloud** (modo mínimo)

| Característica | Descrição |
| --- | --- |
| Pontos fortes | Open source, extremamente popular, interface web rica, acesso via WebDAV/HTTPS, autenticação robusta, pode ser configurado com apenas HTTPS e usuários básicos. |
| Como usar | 💡Navegador, Interface web. |
| Como usar linha de comandos | curl/wget: via API WebDAV ou download direto de URLs autenticadas. |
| Segurança | TLS, autenticação por token, opção de criptografia de dados. |
| Observação | É mais “completo” do que um WebDAV puro, mas pode ser instalado em modo reduzido para ser só armazenamento. |

2. **FileRun**

| Característica | Descrição |
| --- | --- |
| Pontos fortes | Interface web leve, suporte WebDAV, open source na versão `community`. |
| Como usar | URL direta para arquivos (HTTPS), suporta autenticação básica. |
| Segurança | TLS + autenticação. |
| Observação | Menos pesado que Nextcloud, mais próximo de um “WebDAV puro com interface web”. |

3. **Seafile**
   
| Característica | Descrição |
| --- | --- |
| Pontos fortes | Open source, interface web responsiva, cliente opcional mas não obrigatório, API REST HTTP. |
| Como usar | Interface web ou curl/wget para download/upload via API. |
| Segurança | HTTPS, autenticação token-based. |

4. **Caddy + File Browser** (Algo muito minimalista)
   
> 💡 Minha recomendação pela simplicidade e segurança

| Característica | Descrição |
| --- | --- |
| File Browser | um binário único (Go), interface web simples, autenticação de usuários, API HTTP. |
| Caddy | servidor HTTPS automático com certificados Let’s Encrypt. |
| Resultado | Você acessa pelo browser ou baixa/submete arquivos via curl/wget. |
| Segurança | HTTPS, autenticação básica ou JWT. |

Se a ideia é 100% simples e seguro, sem precisar de muita configuração extra, eu iria de File Browser + Caddy:

- Menos de 10 MB no total.
- HTTPS automático.
- Controle de usuários.
- Totalmente open source.
- Usa HTTP puro (então curl/wget funcionam fácil).

# Um exemplo Docker para o Caddy

Segue um exemplo pronto de configuração do File Browser + Caddy para que funcione só com HTTPS e login, sem instalar mais nada no cliente. Isso vai te dar um WebDAV-like seguro e leve.

Um Dockerfile e um docker-compose.yml prontos para rodar Caddy + File Browser, com HTTPS automático via Let’s Encrypt, tudo open source e acessível via navegador ou curl/wget.

## A ideia é:

Caddy na frente cuidando de HTTPS e autenticação.
File Browser servindo os arquivos.
Configuração mínima, mas segura.

1. Estrutura de diretórios
   
```text
meu-servidor/
├── docker-compose.yml
├── Caddyfile
└── filebrowser.db   (será gerado automaticamente)
```

2. docker-compose.yml

```yaml
version: "3.8"
services:
  caddy:
    image: caddy:2
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
    depends_on:
      - filebrowser

  filebrowser:
    image: filebrowser/filebrowser:latest
    restart: unless-stopped
    volumes:
      - ./dados:/srv       # Pasta que será compartilhada
      - ./filebrowser.db:/database.db
    command: [
      "--noauth"           # Desliga auth interna (Caddy cuida disso)
    ]

volumes:
  caddy_data:
  caddy_config:
```

3. Caddyfile
   
Substitua meusite.com pelo seu domínio.

```json
meusite.com {
    reverse_proxy filebrowser:80

    basicauth {
        usuario JDJhJDEwJEN5LzJ2d3NhYlJTbnpEbG5yRXpyQ2JsTXlTYy5tZnFhNUdVVm1Mc3VpN09vUzN1TFphRU1UenlT # senha = "minhasenha"
    }

    tls seu-email@dominio.com
}
```

> ⚠️ Para gerar a senha em formato **bcrypt** (necessário no basicauth):

```shell
docker run --rm caddy:2 caddy hash-password --plaintext minhasenha
```

4. Subir o servidor
```shell
docker compose up -d
```

> ⚠️ Acesse https://meusite.com no navegador → login com o usuário/senha definidos. Ou use curl:

```shell
curl -u usuario:minhasenha -k https://meusite.com/teste.txt -O
```

5. Como funciona
   
O acesso externo ficaria assim:

```
[Usuário externo via HTTPS] 
       ↓ 
[F5 BIG-IP na porta 443 pública]
       ↓  (HTTP interno, ex.: porta 8080)
[Caddy (com autenticação basicauth)]
       ↓  (HTTP interno, porta 80)
[File Browser]
```

>💡 **Então mesmo que o File Browser não esteja “exposto” na internet**, ele continua sendo acessível externamente **por causa do encadeamento F5 → Caddy → File Browser**.

---

O File Browser é acessível externamente via browser ou `curl/wget`, mas **só** pela porta 443 pública:

* **O F5 precisa ter um Virtual Server** apontando para o **Caddy** interno.
* **O Caddy** é quem vai cuidar da autenticação, listagem e entrega dos arquivos.
* O File Browser continua protegido, só atendendo requisições que chegam pelo Caddy.

---




