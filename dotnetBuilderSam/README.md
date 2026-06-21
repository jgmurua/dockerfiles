# dotnetBuilderSam

Imagen para builds .NET 6 con [AWS SAM CLI](https://aws.amazon.com/serverless/sam/) y [SonarScanner](https://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner-for-msbuild/).

## Contenido

- .NET SDK 6.0
- Java (JRE), AWS CLI, zip, Node.js
- AWS SAM CLI
- dotnet-sonarscanner v5.5.0

## Construir

```bash
docker build -t dotnet-builder-sam .
```

## Uso

```bash
docker run --rm \
  -v $(pwd):/src \
  -w /src \
  dotnet-builder-sam \
  sh -c 'dotnet build && dotnet sonarscanner begin ... && dotnet build && dotnet sonarscanner end'
```
