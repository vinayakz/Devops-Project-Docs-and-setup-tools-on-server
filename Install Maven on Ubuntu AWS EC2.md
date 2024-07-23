# Introduction

Apache Maven is an open-source project management tool primarily used to develop Java applications. It incorporates a POM (Project Object Model) approach, which stores information about projects, configurations, and dependencies in an XML file.

## Prerequisites
- A system running Ubuntu.
- Command-line access to the system.
- A user with administrative privileges.

## Download and Install Maven
1. Visit the [Maven download page](https://maven.apache.org/download.cgi)
2. Right-click the version of Maven you want to install and copy the link.

![image](https://github.com/user-attachments/assets/b498fef4-60ff-4525-a8c6-ac1b7b714377)

3. Download the Maven installation file to the /opt directory using the wget command. The syntax is:

```sh
 $ wget [link]
```
Ex : wget https://downloads.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz

Replace [link] with the link to the Maven version you copied in the previous step.

4. Once the download is complete, extract the installation file to the opt directory:

```sh
 $ sudo tar xzf apache-maven-3.8.6-bin.tar.gz
```
- Sudo : Run the command with superuser privileges.
- tar : The command for working with tar archives.
- x : Extract the archive.
- z : Filter the archive through gzip (for .gz files).
- f : Specify the file name of the archive.

5. After Unzip apache-maven-3.8.6-bin file move to maven folder
   ```sh
   $ sudo mv apache-maven-3.8.6-bin maven
   ```
6. Set Up Environment Variables
7. GoTO root directory and edit profile file 
   ```sh
   $ cd ~
   $ ll -a
   $ sudo vim .profile
   ```
   ![image](https://github.com/user-attachments/assets/f91337c3-e163-41fe-9585-25c3421bd915)
   
8. Open .profile Add the following lines to the .profile file
 ```sh
  M2_HOME=/opt/maven
  M2=/opt/maven/bin
  JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
  PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2
 ```
9. Verify Maven Installation
    ```sh
    $ maven -v
    ```
 10. Verify maven path and java path is set or not
  ```sh
    $ echo $PATH
  ```
11. If echo $PATH is showing old path then run this command
  ```sh
    $ source .profile
    $ echo $PATH
  ```    
