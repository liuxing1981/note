# maven note

## add some repo in pom.xml
### search order
* local repo
* center repo
* custom repo

```
#jboss
<repositories>
    <repository>
	    <id>JBoss repository</id>
	    <url>http://repository.jboss.org/nexus/content/groups/public/</url>
    </repository>
</repositories>

#java net
<repositories>
    <repository>
      <id>java.net</id>
      <url>https://maven.java.net/content/repositories/public/</url>
    </repository>
 </repositories>
```

## set proxy
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd" xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<repositories>        
	  <repository>        
		<id> central</id>        
		<name> Maven Repository Switchboard</name>        
		<layout> default</layout>        
		<url> http://repo1.maven.org/maven2</url>        
		<snapshots>        
		  <enabled> false</enabled>        
		</snapshots>        
	  </repository>        
	</repositories>      

	<proxies>
		<proxy>
        <id>myhttpproxy</id>
        <active>true</active>
        <protocol>http</protocol>
        <host>135.245.48.34</host>
        <port>8000</port>
        <nonProxyHosts>localhost</nonProxyHosts>
    </proxy>
    <proxy>
        <id>myhttpsproxy</id>
        <active>true</active>
        <protocol>https</protocol>
        <host>135.245.48.34</host>
        <port>8000</port>
        <nonProxyHosts>localhost</nonProxyHosts>
    </proxy>
	</proxies>
</settings> 
```

## local jar package
```
mvn install:install-file -Dfile=c:\kaptcha-{version}.jar -DgroupId=com.google.code -DartifactId=kaptcha -Dversion={version} -Dpackaging=jar

# local install first and then write to the pom.xml.
<dependency>
      <groupId>com.google.code</groupId>
      <artifactId>kaptcha</artifactId>
      <version>2.3</version>
</dependency>
```

## create a maven project
```
# windows
set groupId=com.luis
set artifactId=readPdf
mvn archetype:generate ^
-DgroupId=%groupId% ^
-DartifactId=%artifactId% ^
-DarchetypeArtifactId=maven-archetype-quickstart ^
-DinteractiveMode=false

# liunx
groupId=com.luis
artifactId=readPdf
mvn archetype:generate \
-DgroupId=$groupId \
-DartifactId=$artifactId\
-DarchetypeArtifactId=maven-archetype-quickstart \
-DinteractiveMode=false
```

## maven complier
```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>2.3.2</version>
    <configuration>
        <source>1.8</source>
        <target>1.8</target>
    </configuration>
</plugin>
```

## junit
```
<dependency>
	<groupId>junit</groupId>
	<artifactId>junit</artifactId>
	<version>4.11</version>
	<scope>test</scope>
</dependency>
```

## Variable
```
    <properties>
        <project.build.name>tools</project.build.name>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
```

