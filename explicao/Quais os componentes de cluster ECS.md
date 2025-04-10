# Quais os componentes de cluster ECS?

## 1 - Simples
- **Cluster**: O núcleo do ECS, onde tarefas e serviços são gerenciados, além de prover poder computacional.
- **Task Definition**: A receita que define como os contêineres devem ser executados (imagem, CPU, memória, variáveis de ambiente e outros).
- **Task**: A execução de uma Task Definition. É o contêiner em execução.
- **Service**: Gerencia a execução de tarefas, garantindo que o número desejado de tarefas esteja sempre em execução.
- **Fonte de Imagem**: Repositório que fornece as imagens de contêiner para as tarefas, como ECR ou Docker Hub.

## 2 - Adicionando complexidade
Esses são componentes de infraestrutura e suporte que tornam o cluster ECS funcional:
- **Launch Template (LT)**: Um modelo que define como as instâncias EC2 devem ser configuradas (tipo, AMI, roles e outros).
- **Capacity Provider (CP)**: Define como o ECS gerencia a capacidade do cluster, seja com instâncias EC2 ou Fargate.
- **Auto Scaling Group (ASG)**: Um grupo de instâncias EC2 que pode escalar automaticamente para atender à demanda do cluster.
- **CloudWatch Logs**: Serviço usado para coletar e monitorar logs das tarefas e serviços ECS.
- **Security Groups (SG)**: Regras de firewall que controlam o tráfego de entrada e saída para instâncias EC2 ou tarefas Fargate.
- **Capacity Provider**: Conecta o ASG ao ECS, permitindo que o ECS gerencie a capacidade do cluster de forma automática.
- **Instância EC2**: Máquina virtual que é criada na infraestrutura da AWS.

## 3 - Refinando e conectando os componentes
### Cluster
- É o ambiente lógico onde as tarefas e serviços ECS são executados.
- Pode usar instâncias EC2 (modo EC2) ou Fargate (modo serverless).

### Launch Template e Auto Scaling Group
- No modo EC2, o **Launch Template** define como as instâncias EC2 serão configuradas.
- O **Auto Scaling Group** gerencia o número de instâncias EC2 no cluster, escalando para cima ou para baixo conforme necessário.

### Capacity Provider
- Gerencia como o ECS aloca capacidade para executar tarefas.
- Pode ser configurado para usar instâncias EC2 (via ASG) ou Fargate.

### Task Definition, Task e Service
- A **Task Definition** define como os contêineres devem ser executados.
- A **Task** é a execução de uma **Task Definition**.
- O **Service** garante que um número desejado de tarefas esteja sempre em execução.

### Fonte de Imagem
- As tarefas ECS precisam de uma imagem de contêiner, que geralmente é armazenada em um repositório como ECR ou Docker Hub.

### CloudWatch Logs
- Coleta logs das tarefas e serviços ECS para monitoramento e depuração.

### Security Group
- Controla o tráfego de rede para as instâncias EC2 ou tarefas Fargate.

### Instância EC2 (Infraestrutura)
- No modo EC2, as instâncias EC2 são a infraestrutura subjacente que executa as tarefas.

---

Portanto, o **ASG** usa o **Launch Template** para criar instâncias EC2 e utiliza o **Capacity Provider** para se integrar ao **ECS** e atender à demanda de tarefas. Essa integração torna o gerenciamento de capacidade mais eficiente e automatizado.

---

## Observações Avançadas
### Fargate vs EC2
- No modo **Fargate**, não é necessário gerenciar instâncias EC2, pois a AWS gerencia a infraestrutura para você.
- No modo **EC2**, você tem mais controle sobre a infraestrutura, mas precisa gerenciar as instâncias.

### Outros componentes indiretos
- **IAM Role**: Permite que o ECS e as tarefas acessem outros serviços da AWS, como Secret Manager, ECR e outros.
- **VPC e Subnets**: Definem a rede onde o cluster ECS opera.