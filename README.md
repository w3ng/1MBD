# SMBD - Simple Managed Build &amp; Deployment

SMBD is a Countinous Integration build framework or extensive build tool that writen in Apache Ant. <br/><br/>
Basic Feature as below : <br/>
* It allows configured once, build everywhere no matter in local machine, ide, or build sever; <br/>
* Easy to Integrate with build tools like Hudson, Jenkins and etc <br/>
* Allow to create own UDF (User Defined Function); <br/>
* Integrate with any typical build process and maven; <br/>
* Capable to deploy to other machines and send notification. <br/>
   
## INSTALLATION

### Prerequisite

SMBD is designed to work with Apache ANT, So we need to perform the following steps before go for SMBD.<br/>

* JAVA SDK 1.8 or above <br/>
Download the SDK version 1.8 or above is high recommanded. <br/>
Link : http://www.oracle.com/technetwork/java/javase/downloads/index.html  <br/>

* Apache ANT 1.9 or above <br/>
Download the ANT version 1.9 or above is high recommanded. <br/>
Link : https://ant.apache.org/bindownload.cgi <br/>

### Install 1SMBD
1. download the zip file from github
2. unzip the file. 
3. create global variable <br/>
   BUILD_HOME=&lt;path&gt;

## USAGE
1. create profile &lt;name&gt;.profile in your projects or application folder.
```
app.source=<name>
app.opts=ALL

#################################################
###            BUILD - LOCAL                 ####
#################################################
local.path=
local.delete=false

#################################################
###            DEPLOY - LOCAL                ####
#################################################
deployer.localhost.path.backup=
```
<br/>

2. create build.xml with the below content in your projects or application folder.
```
<project name="build" default="bt:buildProcess" basedir="." >
	
	<property environment="env"/>			
	<import file="${env.BUILD_HOME}/builder.xml" />

</project>
```
<br/>

3. execute
```
ant -f build.xml
```

## BUGS and ISSUES

Have a bug or an issue with this framework? [Open a new issue](https://github.com/w3ng/1MBD/issues) here on GitHub or <br/>
Email your comments or ideas to me. [Email : wkweng7470@gmail.com](wkweng7470@gmail.com).


## CREATOR

This framework maintained by [Wong Kar Weng](wkweng7470@gmail.com)

## What's Next
Currently creating SMDB version II
* Targeting 90% configuration, 10% or below in coding
* Use JSON instead of text format in configuration
* Support more SCM like github, teamforge.
* support multiple way of notifications.
* simplify build and deployment process.


