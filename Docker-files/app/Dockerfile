FROM openjdk:11 as build_image
WORKDIR /tmp/vprofile
RUN apt update && apt install maven -y
ADD ../.. /tmp/vprofile/
RUN cd /tmp/vprorfile/vproject && mvn install

FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image /tmp/vprorfile/vproject/target/vprofile-v2.war usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh", "run" ]