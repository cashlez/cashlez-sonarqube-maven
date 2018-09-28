FROM maven:alpine

ENV SONAR_VERSION=7.3 \
    SONARQUBE_HOME=/opt/sonarqube

# Http port
EXPOSE 9000

RUN set -x \
    && apk add --no-cache gnupg unzip \
    && apk add --no-cache libressl wget \
    && apk add --no-cache su-exec \
    && apk add --no-cache bash \
    && mkdir /opt \
    && cd /opt \
    && wget -O sonarqube.zip --no-verbose https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && wget -O sonarqube.zip.asc --no-verbose https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && rm sonarqube.zip* \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && cd sonarqube \
    && cd bin

CMD ["sonar.sh"]
