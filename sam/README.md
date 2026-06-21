# sam

Imagen .NET 6 con [AWS SAM CLI](https://aws.amazon.com/serverless/sam/) compilado desde fuente y SonarScanner.

## Contenido

- .NET SDK 6.0
- Java, Python 3, Node.js
- AWS SAM CLI v1.95.0 (compilado desde fuente)
- dotnet-sonarscanner v5.5.0

## Construir

```bash
docker build -t sam-builder .
```

## Uso

```bash
docker run --rm \
  -v $(pwd):/src \
  -w /src \
  -e AWS_ACCESS_KEY_ID=... \
  -e AWS_SECRET_ACCESS_KEY=... \
  sam-builder \
  sam build --use-container
```
