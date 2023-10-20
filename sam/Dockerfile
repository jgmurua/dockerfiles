# Utilizar una imagen base de dotnet 6 para ARM
FROM mcr.microsoft.com/dotnet/sdk:6.0

# Instalar dependencias necesarias
RUN apt-get update -y --fix-missing && \
    apt-get install -y --no-install-recommends \
    default-jre \
    unzip \
    git \
    jq \
    curl \
    wget \
    awscli \
    zip \
    nodejs \
    python3-pip \
    python3-setuptools \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Establecer el PATH para las herramientas .NET globales
ENV PATH="$PATH:/root/.dotnet/tools"

# Instalar herramientas de .NET
RUN dotnet tool install --global dotnet-sonarscanner --version 5.5.0

# Clonar, hacer checkout al tag deseado y compilar AWS SAM CLI
RUN git clone --depth 1 -b v1.95.0 https://github.com/aws/aws-sam-cli.git && \
    cd aws-sam-cli && \
    pip3 install . && \
    cd .. && \
    rm -rf aws-sam-cli
