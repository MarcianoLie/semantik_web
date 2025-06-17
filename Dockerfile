FROM eclipse-temurin:21-jdk

# Install unzip dan curl
RUN apt-get update && apt-get install -y unzip curl

# Unduh GraphDB versi free
RUN curl -L -o graphdb.zip https://download.ontotext.com/owlim/b1d91bea-25d4-11f0-829f-42843b1b6b38/graphdb-11.0.1-dist.zip && \
    unzip graphdb.zip && \
    mv graphdb-free-11.0.1 graphdb && \
    rm graphdb.zip

# Tambahkan konfigurasi dan data RDF
COPY config.ttl /config.ttl
COPY rectoverso.ttl /rectoverso.ttl

# Jalankan GraphDB, buat repo, lalu upload .ttl
CMD bash -c "\
    ./graphdb/bin/graphdb & \
    sleep 15 && \
    curl -X POST http://localhost:7200/rest/repositories \
         -H 'Content-Type: multipart/form-data' \
         -F config=@/config.ttl && \
    curl -X POST http://localhost:7200/repositories/myrepo/statements \
         -H 'Content-Type: text/turtle' \
         --data-binary @/rectoverso.ttl && \
    tail -f /dev/null"
