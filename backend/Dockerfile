FROM maven:3.9.3-eclipse-temurin-20-alpine AS builder
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY ./src ./src
COPY *.xml ./
RUN wget -O  YandexInternalRootCA.crt https://storage.yandexcloud.net/cloud-certs/CA.pem \
    && mvn package -Dversion.application=${VERSION} -Dmaven.test.skip=true 

FROM alpine AS getcurl
RUN apk add --no-cache curl

FROM bellsoft/liberica-runtime-container:jre-17-slim-musl
ARG VERSION=${VERSION}
WORKDIR /app
COPY --from=builder /usr/src/app/YandexInternalRootCA.crt .
RUN keytool -importcert -file YandexInternalRootCA.crt \
    -alias yandex -cacerts -storepass changeit -noprompt \
    && rm -rf YandexInternalRootCA.crt \
    && addgroup --system jaruser \
    && adduser -S -s /bin/false -G jaruser jaruser -D -H \
    && mkdir -p /var/sausage-store/reports /var/sausage-store/logs \
    && chown -R jaruser:jaruser /var/sausage-store/
COPY --from=getcurl /usr/bin/curl /usr/bin/curl
COPY --from=getcurl /lib/ /lib/
COPY --from=getcurl /usr/lib/ /usr/lib/
COPY --chown=jaruser:jaruser \
     --from=builder /usr/src/app/target/sausage-store-${VERSION}.jar ./sausage-store.jar
EXPOSE 8080
USER jaruser
ENTRYPOINT ["java", "-jar", "-Dmyserver.bindPort=8080", "/app/sausage-store.jar"]
