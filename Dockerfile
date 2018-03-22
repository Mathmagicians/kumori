FROM openjdk:9.0.4-jdk

ENV SERVER_ROOT kumori
ENV JAVA_HOME /usr/java/default

WORKDIR /${SERVER_ROOT}

CMD ["java", "-version"]
