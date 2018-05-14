FROM centos:7

MAINTAINER Jian Li <gunine@sk.com>

ENV VERSION 8
ENV UPDATE 171
ENV BUILD 11
ENV SIG 512cd62ec5174c3487ac17c61aaa89e8

ENV JAVA_HOME /usr/lib/jvm/java-${VERSION}-oracle
ENV JRE_HOME ${JAVA_HOME}/jre

RUN yum -y install wget && \
  wget --no-cookies --no-check-certificate \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/"${SIG}"/server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz && \
  tar xvfz server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz -C /tmp && \
  mkdir -p /usr/lib/jvm && mv /tmp/jdk1.${VERSION}.0_${UPDATE} "${JAVA_HOME}" && \
  rm -rf /tmp/* /var/tmp/*

RUN yum -y remove wget; yum -y clean all

RUN update-alternatives --install "/usr/bin/java" "java" "${JRE_HOME}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
	update-alternatives --set java "${JRE_HOME}/bin/java" && \
	update-alternatives --set javac "${JAVA_HOME}/bin/javac"
