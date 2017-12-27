FROM centos:7

ENV SERVER_ROOT kumori
ENV JDK_DOWNLOAD_PATH http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/
ENV JDK_DOWNLOAD_FILE jdk-9.0.1_linux-x64_bin.rpm
ENV JAVA_HOME /usr/java/default

RUN mkdir /${SERVER_ROOT} \
    && cd /${SERVER_ROOT} \
    && yum -y install wget \
    && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" ${JDK_DOWNLOAD_PATH}${JDK_DOWNLOAD_FILE} \
    && yum -y localinstall ${JDK_DOWNLOAD_FILE} \
    && rm ${JDK_DOWNLOAD_FILE}

WORKDIR /${SERVER_ROOT}

CMD ["java", "-version"]
