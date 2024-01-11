# Build Stage
FROM maven:3.8.3-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /home/centos/Javaweb3-K8S/src/main

# Copy the POM file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the application source code
COPY src src

# Build the application
RUN mvn package

# Final Stage
FROM tomcat:9.0-jdk11-openjdk-slim

# Set the working directory to the Tomcat webapps directory
WORKDIR /usr/local/tomcat/webapps

# Set environment variables for Nexus installation
ENV NEXUS_VERSION 3.38.0-01
ENV NEXUS_HOME /opt/sonatype/nexus

# Download and extract Nexus
RUN mkdir -p ${NEXUS_HOME} && \
    wget -O /tmp/nexus.tar.gz https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz && \
    tar -zxvf /tmp/nexus.tar.gz -C ${NEXUS_HOME} --strip-components=1 && \
    rm /tmp/nexus.tar.gz && \
    sed -i '/^#.*karaf./s/^#//' ${NEXUS_HOME}/bin/nexus.vmoptions

# Copy the built WAR file from the Maven build stage to Tomcat webapps directory
COPY --from=build /home/centos/Javaweb3-K8S/src/main/target/WebAppCal-0.0.6.war .

# Expose Nexus and Tomcat ports
EXPOSE 8081 8080

# Start Nexus and Tomcat
CMD ${NEXUS_HOME}/bin/nexus run && ${CATALINA_HOME}/bin/catalina.sh run
