FROM centos:7

ENV SERVER_ROOT kumori
ENV JDK_DOWNLOAD_PATH http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/
ENV JDK_DOWNLOAD_FILE jdk-8u144-linux-x64.rpm
ENV JAVA_HOME /usr/java/jdk1.8.0_144/jre

RUN mkdir /${SERVER_ROOT} \
    && cd /${SERVER_ROOT} \
    && yum -y install wget \
    && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" ${JDK_DOWNLOAD_PATH}${JDK_DOWNLOAD_FILE} \
    && yum -y localinstall ${JDK_DOWNLOAD_FILE} \
    && rm ${JDK_DOWNLOAD_FILE}

WORKDIR /${SERVER_ROOT}

CMD ["java", "-version"]
