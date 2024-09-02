FROM node:22.7.0-bullseye-slim


RUN apt-get update && \
    apt-get install -y curl unzip jq git ansible python3-boto3 && \
    apt-get clean && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    curl -s https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js | node

WORKDIR /opt/cronicle/
EXPOSE 3012

ADD entrypoint.sh /entrypoint.sh
CMD ["sh", "/entrypoint.sh"]
