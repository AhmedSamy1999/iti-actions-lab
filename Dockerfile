# First stage: Build the application
FROM maven:3.9.5-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn clean package

# second stage
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar


ENTRYPOINT ["java", "-jar", "app.jar"]
