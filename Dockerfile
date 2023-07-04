FROM maven:3.9.0 as build
COPY pom.xml ./pom.xml
RUN mvn -DskipTests clean package
COPY src ./src
RUN mvn -B -DskipTests clean package

FROM openjdk:8-jre-alpine
COPY --from=build target/my-app-*.jar my-app.jar
CMD ["java", "-jar", "my-app.jar"]