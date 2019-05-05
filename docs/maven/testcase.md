```
#不执行测试用例，但编译测试用例类生成相应的class文件至target/test-classes下。
mvn -DskipTests clean install

#不执行测试用例，也不编译测试用例类。
mvn -Dmaven.test.skip=true clean install
```