FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN apt-get update -y --fix-missing  && \
    apt-get install -y default-jre unzip git jq curl wget awscli zip nodejs

ENV PATH="$PATH:/root/.dotnet/tools"
RUN dotnet tool install --global dotnet-sonarscanner --version 5.5.0

RUN apt-get install -y nodejs

# install SAM
RUN wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip && \
    unzip aws-sam-cli-linux-x86_64.zip -d sam-installation && \
    rm -rf aws-sam-cli-linux-x86_64.zip && \
    chmod +x sam-installation/install && \
    ./sam-installation/install && \
	rm -rf sam-installation