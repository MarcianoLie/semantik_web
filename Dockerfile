FROM eclipse-temurin:21-jdk

# Install unzip dan curl
RUN apt-get update && apt-get install -y unzip curl

# Download dan ekstrak Apache Jena Fuseki versi 5.4.0
RUN curl -L -o fuseki.zip https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-5.4.0.zip && \
    unzip fuseki.zip && mv apache-jena-fuseki-5.4.0 fuseki && rm fuseki.zip

# Copy file konfigurasi dan data RDF
COPY fuseki-config.ttl /fuseki/config.ttl
COPY data.ttl /fuseki/data.ttl

# Jalankan Fuseki di port Railway (3000)
CMD ["./fuseki/fuseki-server", "--config=config.ttl", "--port=3000", "--localhost=0.0.0.0"]
