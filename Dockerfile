# Use an official OpenJDK runtime as a base image
FROM openjdk:11-jre-slim

# Set the working directory to /app
WORKDIR /app

# Copy the application WAR file into the container at /app
COPY target/WebAppCal-0.0.6.war /app

# Specify the command to run your application
CMD ["java", "-jar", "WebAppCal-0.0.6.war"]
