<<<<<<< HEAD
#Use an official Tomcat runtime as the base image
FROM tomcat:latest

# Copy the WAR file from the target directory to Tomcat webapps
COPY target/*.war /usr/local/tomcat/webapps/

=======
# Use the official Tomcat base image
FROM tomcat:latest

# Remove the default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WebAppCal-0.0.6.war file to the webapps directory in Tomcat
COPY target/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
>>>>>>> b3d9435fd92bbb2f4ca33db954da009b69daa13e
