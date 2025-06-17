FROM eclipse-temurin:21

# Install unzip + curl
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Download and extract Fuseki
RUN curl -L -o graphdb.zip https://download.ontotext.com/graphdb/graphdb-11.0.1-dist.zip && \
    unzip graphdb.zip && \
    mv graphdb-11.0.1 fuseki && \
    rm graphdb.zip

# Copy config.ttl to /fuseki/config.ttl
COPY config.ttl /fuseki/config.ttl

# Expose port
EXPOSE 3000

# Make sure it binds to 0.0.0.0
ENV JAVA_OPTIONS="-Djetty.host=0.0.0.0"

# Start Fuseki
CMD ["./fuseki/fuseki-server", "--config=config.ttl", "--port=3000"]
