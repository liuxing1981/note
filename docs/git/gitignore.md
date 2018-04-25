# gitignore


### 生效方法
```
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

### 过滤规则
```
/mtk/             过滤整个文件夹
*.zip             过滤所有.zip文件
/mtk/do.c         过滤某个具体文件
```

### 增加规则
```
!/mtk/one.java    把one这个文件纳入git管理
```

### 配置规则
* “/”开头表示目录；
* “*”通配多个字符；
* “?”通配单个字符
* “[]”包含单个字符的匹配列表；
* “!”表示不忽略(跟踪)匹配到的文件或目录；

### 举例
* 规则：fd1/*
> 说明：忽略目录fd1下的全部内容；注意，不管是根目录下的 /fd1/ 目录，还是某个子目录 /child/fd1/ 目录，都会被忽略；
* 规则：/fd1/*
> 说明：忽略根目录下的 /fd1/ 目录的全部内容；

### jhipster的gitignore参考
```
######################
# Project Specific
######################
/target/www/**
/src/test/javascript/coverage/
/src/test/javascript/PhantomJS*/

######################
# Node
######################
/node/
node_tmp/
node_modules/
npm-debug.log.*

######################
# SASS
######################
.sass-cache/

######################
# Eclipse
######################
*.pydevproject
.project
.metadata
tmp/
tmp/**/*
*.tmp
*.bak
*.swp
*~.nib
local.properties
.classpath
.settings/
.loadpath
.factorypath
/src/main/resources/rebel.xml

# External tool builders
.externalToolBuilders/**

# Locally stored "Eclipse launch configurations"
*.launch

# CDT-specific
.cproject

# PDT-specific
.buildpath

######################
# Intellij
######################
.idea/
*.iml
*.iws
*.ipr
*.ids
*.orig
classes/

######################
# Visual Studio Code
######################
.vscode/

######################
# Maven
######################
/log/
/target/

######################
# Gradle
######################
.gradle/
/build/

######################
# Package Files
######################
*.jar
*.war
*.ear
*.db

######################
# Windows
######################
# Windows image file caches
Thumbs.db

# Folder config file
Desktop.ini

######################
# Mac OSX
######################
.DS_Store
.svn

# Thumbnails
._*

# Files that might appear on external disk
.Spotlight-V100
.Trashes

######################
# Directories
######################
/bin/
/deploy/

######################
# Logs
######################
*.log

######################
# Others
######################
*.class
*.*~
*~
.merge_file*

######################
# Gradle Wrapper
######################
!gradle/wrapper/gradle-wrapper.jar

######################
# Maven Wrapper
######################
!.mvn/wrapper/maven-wrapper.jar

######################
# ESLint
######################
.eslintcache
```