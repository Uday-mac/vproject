FROM openjdk:17-jdk as build_image
RUN apt update 
RUN apt install maven -y 
RUN git clone -b main https://github.com/Uday-mac/vproject.git
RUN cd vproject
RUN mvn install


FROM tomcat:10-jre17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image vproject/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]