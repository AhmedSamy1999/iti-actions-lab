FROM maven:3.9.5-eclipse-temurin-17 as build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
# Copy source code
COPY ./my-java-app ./my-java-app
# Package the application
RUN mvn -f my-java-app/pom.xml clean package



# Second stage
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy the jar file from the build stage
COPY --from=build /app/my-java-app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
