FROM openjdk:11

WORKDIR /home/centos/Javaweb3-K8S

# Copy the JAR file from the target directory
COPY target/WebAppCal-0.0.6.war /home/centos/Javaweb3-K8S/app.jar

# Add the YAML configuration file
ADD javaweb3-K8S.yaml app-config.yaml

EXPOSE 8080

# Set the entry point
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "server", "app-config.yaml"]
