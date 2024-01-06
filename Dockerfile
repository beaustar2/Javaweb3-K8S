FROM openjdk:11.0.21
WORKDIR /home/centos/Javaweb3-K8S
COPY target/WEB-INF/lib/servlet-api-2.5.jar /home/centos/Javaweb3-K8S
ADD javaweb3-K8S.yaml app-config.yaml
EXPOSE 8080
CMD ["java", "-jar", "servlet-api-2.5.jar"]