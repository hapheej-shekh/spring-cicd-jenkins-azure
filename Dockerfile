# -------------------------------
# Use a lightweight Java 11 base image
FROM openjdk:11-jdk-slim

# Optional: Set timezone (if needed for logs)
ENV TZ=Asia/Kolkata

# Set environment variable for active Spring profile (override via `docker run -e`)
ENV SPRING_PROFILES_ACTIVE=dev

# Set working directory
WORKDIR /spring-cicd-jenkins-azure

# Copy JAR file to container
# IMPORTANT: Replace with your actual JAR name
#COPY target/spring-cicd-jenkins-azure-0.0.1.jar azure-jenkins-app.jar
COPY target/*.jar azure-jenkins-app.jar

# Expose the port your docker-app listens on (default: 8080)
EXPOSE 8084

# Run the application
ENTRYPOINT ["java", "-jar", "azure-jenkins-app.jar"]
