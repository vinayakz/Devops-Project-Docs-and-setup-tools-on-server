# Tomcat installation on EC2 instance
### Pre-requisites
1. EC2 instance with Java 11
Step 1: To install Java 11 on an Ubuntu EC2 instance, you can follow these steps
```sh
  sudo apt update
```
Step 2: Install OpenJDK 11
```sh
  sudo apt install openjdk-11-jdk -y
```
Step 3: Verify the Installation
```sh 
  java -version
```
You should see output similar to this:
```sh
  Openjdk version "11.0.x" 202x-xx-xx
  OpenJDK Runtime Environment (build 11.0.x+xx)
  OpenJDK 64-Bit Server VM (build 11.0.x+xx, mixed mode)
```
### Install Apache Tomcat
1. Download tomcat packages from  https://tomcat.apache.org/download-80.cgi onto /opt on EC2 instance
   > Note: Make sure you change `<version>` with the tomcat version which you download. 
```sh
  # Create tomcat directory
  $ cd /opt
  $ wget [link]
  $ wget http://mirrors.fibergrid.in/apache/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz
  $ tar -xvzf /opt/apache-tomcat-<version>.tar.gz
```
2. Create tomcat directory
  ```sh
    sudo mv apache-tomcat-<version> tomcat
  ```
3. Give executing permissions to startup.sh and shutdown.sh which are under bin.
  ```sh
   $ chmod +x /opt/apache-tomcat-<version>/bin/startup.sh 
   $ chmod +x /opt/apache-tomcat-<version>/bin/shutdown.sh
  ```
  > Note: you may get below error while starting tomcat incase if you dont install Java 
  `Neither the JAVA_HOME nor the JRE_HOME environment variable is defined At least one of these environment variable is needed to run this program`

4. Create link files for tomcat startup.sh and shutdown.sh 
    ```sh
     ln -s /opt/apache-tomcat-<version>/bin/startup.sh /usr/local/bin/tomcatup
     ln -s /opt/apache-tomcat-<version>/bin/shutdown.sh /usr/local/bin/tomcatdown
     tomcatup
   ```
## Check point :
Access tomcat application from browser on port 8080
  - http://<Public_IP>:8080

Using unique ports for each application is a best practice in an environment. But tomcat and Jenkins runs on ports number 8080. Hence lets change tomcat port number to 8090. Change port number in conf/server.xml file under tomcat home
   ```sh
 cd /opt/apache-tomcat-<version>/conf
# update port number in the "connecter port" field in server.xml
# restart tomcat after configuration update
tomcatdown
tomcatup
```
#### Check point :
Access tomcat application from browser on port 8090  
 - http://<Public_IP>:8090

5. now application is accessible on port 8090. but tomcat application doesnt allow to login from browser. changing a default parameter in context.xml does address this issue
```sh
   #search for context.xml
   $ find / -name context.xml
```
6. Above command gives 3 context.xml files. comment (<!-- & -->) `Value ClassName` field on files which are under webapp directory. 
  After that restart tomcat services to effect these changes. 
  At the time of writing this lecture below 2 files are updated.

  ```sh
      $ sudo find / -name context.xml
  ```
    > After run this command you get below output 
      ```sh
          /opt/tomcat/conf/context.xml
          /opt/tomcat/webapps/manager/META-INF/context.xml
          /opt/tomcat/webapps/examples/META-INF/context.xml
          /opt/tomcat/webapps/host-manager/META-INF/context.xml
          /opt/tomcat/webapps/docs/META-INF/context.xml
      ```
     ```sh
        /opt/tomcat/webapps/host-manager/META-INF/context.xml
       /opt/tomcat/webapps/manager/META-INF/context.xml

        # Restart tomcat services
     $ tomcatdown  
     $ tomcatup
     ```
7. Update users information in the tomcat-users.xml file goto tomcat home directory and Add below users to conf/tomcat-users.xml file

  ```sh
	<role rolename="manager-gui"/>
	<role rolename="manager-script"/>
	<role rolename="manager-jmx"/>
	<role rolename="manager-status"/>
	<user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
	<user username="deployer" password="deployer" roles="manager-script"/>
	<user username="tomcat" password="s3cret" roles="manager-gui"/>
   ```

8. Restart serivce and try to login to tomcat application from the browser. This time it should be Successful



      
    


