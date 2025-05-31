
FROM maven:3.9.5-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline

# Copy source code
COPY ./my-java-app ./my-java-app

# Build 
WORKDIR /app/my-java-app
RUN mvn clean package

# Second stage
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy the built JAR file from the build stage
COPY --from=build /app/my-java-app/target/*.jar app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
