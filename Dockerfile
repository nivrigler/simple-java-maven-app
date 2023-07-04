FROM maven:3.9.0 as build
ARG VERSION
COPY pom.xml ./pom.xml
RUN sed -i "s/1.0-SNAPSHOT/${VERSION}/g" pom.xml
RUN mvn -DskipTests clean package
COPY src ./src
RUN mvn -B -DskipTests clean package

FROM openjdk:8-jre-alpine
COPY --from=build target/my-app-*.jar .
CMD java -jar my-app-*.jar