echo 'aws ecs update-service --cluster cluster-bia --service service-bia-web --force-new-deployment' > deploy.sh

aws ecs update-service --cluster cluster-bia --service service-bia-web --force-new-deployment


BUILD E PUSH IMAGEM PARA O ECR

echo 'ECR_REGISTRY="<uri-ecr>"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
docker build -t bia .
docker tag bia:latest $ECR_REGISTRY/bia:latest
docker push $ECR_REGISTRY/bia:latest' > build.sh && chmod +x build.sh && ./build.sh


CRIAR REPO ECR
terraform apply --target=aws_ecr_repository.bia_tf --auto-approve

Substituir IP da API no Dockerfile
Você pode usar o comando `sed` no Bash para substituir o IP `http://34.239.240.133` por `http://y` diretamente no arquivo Dockerfile.

```bash
sed -i 's|http://34.239.240.133|http://3.235.169.167|g' Dockerfile
```

### Explicação do comando:
- `sed`: Comando para edição de texto.
- `-i`: Edita o arquivo no local (in-place).
- `'s|http://34.239.240.133|http://35.238.20.13|g'`:
  - `s|...|...|`: Substitui o texto entre `|`.
  - `http://34.239.240.133`: O texto a ser substituído.
  - `http://35.238.20.13`: O novo texto.
  - `g`: Aplica a substituição globalmente em todas as ocorrências no arquivo.
- Dockerfile: Caminho para o arquivo Dockerfile.

### Após executar:
- O IP será substituído no arquivo Dockerfile.
- Você pode verificar se a substituição foi feita corretamente com:


---
sed -i 's|http://35.238.20.13|http://3.235.169.167|g' Dockerfile

grep "http://3.235.169.167" Dockerfile


ssh -i "x.pem" ec2-user@IP|DNS-IP