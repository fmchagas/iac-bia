# Projeto IaC com Terraform - Cluster ECS

Este projeto utiliza **Terraform** para provisionar e gerenciar a infraestrutura de um cluster ECS (Elastic Container Service) na AWS. Ele inclui recursos como instâncias EC2, grupos de segurança, banco de dados RDS, repositório ECR, e outros componentes necessários para executar aplicações em contêineres.

## Estrutura do Projeto

### Recursos Principais
- **Cluster ECS**: Gerencia as tarefas e serviços em contêineres.
- **Auto Scaling Group (ASG)**: Escala automaticamente as instâncias EC2 para atender à demanda.
- **Launch Template**: Define a configuração das instâncias EC2.
- **RDS (PostgreSQL)**: Banco de dados para a aplicação.
- **ECR**: Repositório para armazenar imagens de contêiner.
- **CloudWatch Logs**: Coleta logs das tarefas ECS.
- **Grupos de Segurança (Security Groups)**: Controla o tráfego de rede para os recursos.
- **IAM Roles**: Permissões para ECS, EC2 e tarefas.

### Arquivos Importantes
- `variables.tf`: Declaração de variáveis utilizadas no projeto.
- `outputs.tf`: Saídas do Terraform após a execução.
- `terraform.tfstate.backup`: Backup do estado do Terraform.

---

## Pré-requisitos

Antes de começar, certifique-se de ter:
1. **Terraform** instalado (versão 1.10.5 ou superior).
2. Uma conta AWS com credenciais configuradas no seu ambiente local.
3. Permissões adequadas para criar e gerenciar recursos na AWS.
