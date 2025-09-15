FROM maven:3.8.6-jdk-8 AS build

WORKDIR /app
COPY .mvn .mvn
COPY mvnw pom.xml ./
RUN mvn dependency:go-offline
COPY src/main ./src/main
RUN mvn -B package -DskipTests

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh

RUN apk add --no-cache bash
RUN chmod +x wait-for-it.sh

CMD  ["./wait-for-it.sh", "-t", "60", "postgres:5432", "--", \
      "./wait-for-it.sh", "-t", "60", "rabbitmq:5672", "--", \
      "./wait-for-it.sh", "-t", "60", "hotel-service:8082", "--", \
      "./wait-for-it.sh", "-t", "60", "payment-service:8084", "--", \
      "./wait-for-it.sh", "-t", "60", "loyalty-service:8085", "--", \
      "java", "-jar", "/app/app.jar"]