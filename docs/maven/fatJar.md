## shade
```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-shade-plugin</artifactId>
	<version>3.2.1</version>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>shade</goal>
			</goals>
			<configuration>
				<transformers>
					<transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
						<mainClass>com.nokia.instrument.Main</mainClass>
					</transformer>
				</transformers>
		        <createDependencyReducedPom>false</createDependencyReducedPom>
			</configuration>
		</execution>
	</executions>
</plugin>
```

## assembly
```
<plugin>
	<artifactId>maven-assembly-plugin</artifactId>
	<configuration>
		<finalName>${project.artifactId}</finalName>
		<appendAssemblyId>false</appendAssemblyId>
		<archive>
			<!--<manifestFile>META-INF/MANIFEST.MF</manifestFile>-->
			<manifestEntries>
				<Agent-Class>com.nokia.instrument.DurationAgent</Agent-Class>
				<Can-Redefine-Classes>true</Can-Redefine-Classes>
				<Can-Retransform-Classes>true</Can-Retransform-Classes>
				<premain-class>com.nokia.instrument.DurationAgent</premain-class>
			</manifestEntries>
		</archive>
		<descriptorRefs>
			<descriptorRef>jar-with-dependencies</descriptorRef>
		</descriptorRefs>
	</configuration>
	<executions>
		<execution>
			<id>make-assembly</id> <!-- this is used for inheritance merges -->
			<phase>package</phase> <!-- bind to the packaging phase -->
			<goals>
				<goal>single</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

## maven-jar-plugin
> copy the 
```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-jar-plugin</artifactId>
	<version>3.1.0</version>
	<configuration>
		<archive>
			<manifest>
				<!-- <useUniqueVersions>0.0.1</useUniqueVersions> -->
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

<plugin> 
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-dependency-plugin</artifactId> 
	<executions>
		<execution> 
			<id>copy</id> 
			<phase>compile</phase> 
			<goals> 
				<goal>copy-dependencies</goal> 
			</goals> 
			<configuration> 
				<outputDirectory>${project.build.directory}/lib</outputDirectory>
			</configuration> 
		</execution> 
	</executions> 
</plugin>
```