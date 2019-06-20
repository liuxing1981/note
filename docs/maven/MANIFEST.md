# MANIFEST


### how to add with maven
## maven-jar-plugin
> 
```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-jar-plugin</artifactId>
	<version>3.1.0</version>
	<configuration>
		<archive>
			<manifest>
				<useUniqueVersions>0.0.1</useUniqueVersions>
				<mainClass>com.isoftstone.hag.Hag</mainClass>
				<addClasspath>true</addClasspath>
				<addDefaultImplementationEntries>true</addDefaultImplementationEntries>
				<addDefaultSpecificationEntries>true</addDefaultSpecificationEntries>
				<addExtensions>true</addExtensions>
				<classpathPrefix>lib/</classpathPrefix>
			</manifest>
			<addMavenDescriptor>true</addMavenDescriptor>
		</archive>
		<!--
		 use an existed file
		<archive>
			<manifestFile>META-INF/MANIFEST.MF</manifestFile>
		</archive> -->
	</configuration>
</plugin>
```


