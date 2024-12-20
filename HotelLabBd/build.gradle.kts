plugins {
	java
	war
	id("org.springframework.boot") version "3.3.5"
	id("io.spring.dependency-management") version "1.1.6"
}

group = "com.fatec.HotelLabBd"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(17)
	}
}

configurations {
	compileOnly {
		extendsFrom(configurations.annotationProcessor.get())
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	
	implementation("org.springframework.boot:spring-boot-starter-web")
	compileOnly("org.projectlombok:lombok")
	developmentOnly("org.springframework.boot:spring-boot-devtools")
	runtimeOnly("com.microsoft.sqlserver:mssql-jdbc")
	annotationProcessor("org.projectlombok:lombok")
	providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")
	
	
	// https://mvnrepository.com/artifact/org.apache.tomcat/tomcat-jasper
	// implementation("org.apache.tomcat:tomcat-jasper:11.0.1")
	
	// https://mvnrepository.com/artifact/net.sf.jasperreports/jasperreports
	implementation("net.sf.jasperreports:jasperreports:6.21.0")
	
	// https://mvnrepository.com/artifact/org.slf4j/slf4j-api
	implementation("org.slf4j:slf4j-api:2.0.12")
	
	// https://mvnrepository.com/artifact/com.github.librepdf/openpdf
	// implementation("com.github.librepdf:openpdf:1.3.30")
	
	// https://mvnrepository.com/artifact/com.lowagie/itext
	// implementation("com.lowagie:itext:2.1.7")
	// implementation ("com.lowagie:itext:2.1.7.js8")

	
	// https://mvnrepository.com/artifact/jakarta.servlet/jakarta.servlet-api
	compileOnly("jakarta.servlet:jakarta.servlet-api:6.0.0")
	
	// https://mvnrepository.com/artifact/jakarta.servlet.jsp/jakarta.servlet.jsp-api
	compileOnly("jakarta.servlet.jsp:jakarta.servlet.jsp-api:4.0.0")
	
	// https://mvnrepository.com/artifact/jakarta.servlet.jsp.jstl/jakarta.servlet.jsp.jstl-api
	implementation("jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.2")
	
	// https://mvnrepository.com/artifact/org.glassfish.web/jakarta.servlet.jsp.jstl
	implementation("org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1")
	
	// https://mvnrepository.com/artifact/jakarta.el/jakarta.el-api
	implementation("jakarta.el:jakarta.el-api:6.0.0")
	
	// https://mvnrepository.com/artifact/jakarta.annotation/jakarta.annotation-api
	implementation("jakarta.annotation:jakarta.annotation-api:3.0.0")
	
	// https://mvnrepository.com/artifact/jakarta.xml.bind/jakarta.xml.bind-api
	implementation("jakarta.xml.bind:jakarta.xml.bind-api:4.0.2")
	
	// https://mvnrepository.com/artifact/org.apache.tomcat.embed/tomcat-embed-jasper
	implementation("org.apache.tomcat.embed:tomcat-embed-jasper:10.1.29")
	
}

tasks.withType<Test> {
	useJUnitPlatform()
}
