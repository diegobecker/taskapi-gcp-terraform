# TaskApi – .NET + Cloud Run + Terraform

Este projeto é um laboratório técnico que demonstra a construção e o deploy de uma API backend em .NET utilizando containers, infraestrutura como código com Terraform e execução serverless no Google Cloud Run.

O foco do projeto é praticar:
- Backend APIs em .NET
- Containerização com Docker
- Infraestrutura como Código (Terraform)
- Deploy em GCP (Cloud Run + Artifact Registry)
- Boas práticas de organização, custos e automação

---

## 🧱 Arquitetura (visão geral)

- **Backend:** ASP.NET Core Web API (.NET 8)
- **Container:** Docker (multi-stage)
- **Infra:** Terraform
- **Cloud Provider:** Google Cloud Platform (GCP)
- **Compute:** Cloud Run (serverless)
- **Registry:** Artifact Registry
- **Build:** Cloud Build
- **State Terraform:** Google Cloud Storage (GCS)

---

## 📁 Estrutura do repositório

repo/
├─ backend/
│ └─ TaskApi/
│ ├─ Controllers/
│ ├─ Models/
│ ├─ Repositories/
│ ├─ Program.cs
│ ├─ TaskApi.csproj
│ └─ Dockerfile
│
├─ infra/
│ ├─ main.tf
│ ├─ provider.tf
│ ├─ variables.tf
│ ├─ versions.tf
│ └─ outputs.tf
│
└─ .gitignore


---

## 🚀 Backend (.NET API)

### Tecnologias
- .NET 8 (LTS)
- ASP.NET Core Web API
- Controllers + Dependency Injection
- Swagger para documentação
- Health Check para monitoramento

### Principais arquivos

- **Program.cs**
  - Configuração da aplicação
  - Registro de serviços
  - Swagger
  - Health check
  - Mapeamento das rotas

- **Controllers/TasksController.cs**
  - Define as rotas REST:
    - `GET /api/tasks`
    - `GET /api/tasks/{id}`
    - `POST /api/tasks`
    - `PUT /api/tasks/{id}`
    - `DELETE /api/tasks/{id}`

- **Models/TaskItem.cs**
  - Modelo de domínio da API

- **Repositories/**
  - Repositório em memória (InMemory)
  - Usado para simplificar o laboratório e focar em infra e deploy

### Rotas auxiliares
- `GET /health`  
  Definida diretamente no `Program.cs` usando Minimal API.

---

## 📦 Containerização

A aplicação é empacotada usando um **Dockerfile multi-stage**, localizado em: backend/TaskApi/Dockerfile


### Características
- Build com `mcr.microsoft.com/dotnet/sdk:8.0`
- Runtime com `mcr.microsoft.com/dotnet/aspnet:8.0`
- Porta padrão `8080` (compatível com Cloud Run)
- Uso de `ASPNETCORE_URLS`

---

## ☁️ Infraestrutura (Terraform)

Toda a infraestrutura é criada usando Terraform e está localizada em: infra/


### Recursos provisionados

- **Google Cloud Storage**
  - Bucket para state remoto do Terraform
  - Versionamento habilitado

- **Artifact Registry**
  - Repositório Docker para armazenar imagens da aplicação

- **Cloud Run**
  - Serviço serverless que executa o container
  - Escala automática
  - Service Account dedicada
  - Acesso público habilitado (ambiente de laboratório)

### Arquivos principais

- `versions.tf` – versões e backend remoto
- `provider.tf` – configuração do provider GCP
- `variables.tf` – variáveis reutilizáveis
- `main.tf` – definição dos recursos
- `outputs.tf` – outputs úteis (URL do serviço)

---

## 🔄 Build e Deploy

### Build da imagem
- O build da imagem Docker é feito usando **Google Cloud Build**
- Isso garante compatibilidade `linux/amd64` (necessária para Cloud Run)

### Deploy
- A imagem é publicada no **Artifact Registry**
- O serviço do Cloud Run é atualizado via **Terraform**

---

## 📊 Observabilidade

- **Health check:** `/health`
- **Logs:** Cloud Logging (via Cloud Run)
- **Swagger:** `/swagger/index.html`

---

## 🔐 Segurança (estado atual)

- Service Account dedicada para o Cloud Run
- Permissões mínimas necessárias
- Sem segredos hardcoded no código

> Autenticação e autorização ainda não implementadas (fora do escopo atual).

---

## 💰 Controle de custos

Este projeto utiliza serviços serverless (Cloud Run), que escalam para zero quando não há tráfego.
Além disso, o projeto possui:
- Budget configurado no GCP
- Alertas de custo por email

Detalhes completos na seção “Controle de Custos”.

---

## 🧭 Próximos passos

- Implementar CI/CD com GitHub Actions
- Automatizar build e deploy
- Evoluir autenticação e persistência




