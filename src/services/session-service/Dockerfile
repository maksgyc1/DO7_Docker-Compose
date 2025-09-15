FROM maven:3.8.6-jdk-8 AS build
WORKDIR /app
COPY .mvn .mvn
COPY mvnw pom.xml ./
RUN mvn dependency:go-offline
COPY src/main ./src/main
RUN mvn package -DskipTests

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
COPY wait-for-it.sh .
RUN apk add --no-cache bash
RUN chmod +x wait-for-it.sh

CMD ["./wait-for-it.sh", "-t", "60", "postgres:5432", "--", \
    "java", "-jar", "/app/app.jar"]