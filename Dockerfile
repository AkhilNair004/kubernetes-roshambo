FROM tomcat:9.0.73
COPY target/roshambo.war /usr/local/tomcat/webapps/roshambo.war
