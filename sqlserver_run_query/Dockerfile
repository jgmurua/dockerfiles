# Utilizar una imagen de Ubuntu 23.10 como base
FROM ubuntu:23.10

# Actualizar el sistema e instalar dependencias
RUN apt-get update && \
    apt-get -y install apt-transport-https curl software-properties-common && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)" && \
    apt-get update && \
    apt-get -y install unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Descargar e instalar mssql-tools
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-tools.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get -y install mssql-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# Copiar el script Bash para ejecutar SQL
COPY sql_runner.sh /sql_runner.sh
RUN chmod +x /sql_runner.sh

# Establecer variables de entorno para la conexión a SQL Server
ENV SQL_SERVER_HOST server
ENV SQL_DATABASE dbname
ENV SQL_USER user
ENV SQL_PASSWORD pass
ENV QUERY query

# Establecer el punto de entrada para ejecutar el script
CMD ["/sql_runner.sh"]
