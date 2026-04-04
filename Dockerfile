FROM eclipse-temurin:17-jdk

# Set the working directory
WORKDIR /app

# Copy the JAR file produced by Maven
COPY target/demo-workshop-2.1.2.jar app.jar

# Expose port (optional)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
