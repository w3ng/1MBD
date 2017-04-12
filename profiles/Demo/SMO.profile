app.source=Demo

app.version.dt=yyyyMMdd_HHmmss
app.version=FLH.SMO.BD1.FY15.1

app.opts=ALL,demoWeb,mapreduce,libs,scripts
app.deploy.destVar=WebServer

builder.ALL.mapper=demoWeb,mapreduce,libs,scripts
builder.demoWeb.mapper=
builder.mapreduce.mapper=scripts
builder.libs.mapper=

app.test=123

#################################################
###            BUILD - LOCAL                 ####
#################################################
local.path=${env.SRCSPACE}/${app.source}
local.delete=false

#################################################
###            DEPLOY - LOCAL                ####
#################################################
deployer.localhost.path.backup=C:\\opt\\backup

deployer.localhost.demoWeb.source=demoWeb.war
deployer.localhost.demoWeb.path.deploy=${env.CATALINA_HOME}/webapps
deployer.localhost.demoWeb.path.dump=${env.CATALINA_HOME}/work/Catalina/localhost
deployer.localhost.demoWeb.start=${env.CATALINA_HOME}/bin/startup.bat
deployer.localhost.demoWeb.stop=${env.CATALINA_HOME}/bin/shutdown.bat

deployer.localhost.libs.source=lib
deployer.localhost.libs.path.deploy=${env.DEMO_HOME}
deployer.localhost.libs.path.dump=
deployer.localhost.libs.start=
deployer.localhost.libs.stop=

deployer.localhost.mapreduce.source=mapreduce.jar
deployer.localhost.mapreduce.path.deploy=${env.DEMO_HOME}/apps
deployer.localhost.mapreduce.path.dump=
deployer.localhost.mapreduce.start=
deployer.localhost.mapreduce.stop=

deployer.localhost.scripts.source=bin
deployer.localhost.scripts.path.deploy=${env.DEMO_HOME}
deployer.localhost.scripts.path.dump=
deployer.localhost.scripts.start=
deployer.localhost.scripts.stop=

#################################################
###              REMOTE                      ####
#################################################

deployer.WebServer.username=root
deployer.WebServer.keyfile=${user.home}/.ssh/id_rsa
deployer.WebServer.passphrase=

deployer.WebServer.demoWeb.path.resources=demoWeb.war
deployer.WebServer.demoWeb.path.deploy=$CATALINA_HOME/webapps
deployer.WebServer.demoWeb.path.dump=$CATALINA_HOME/work
deployer.WebServer.demoWeb.path.backup=/root/Desktop/backup
deployer.WebServer.demoWeb.start=sh $CATALINA_HOME/bin/startup.sh
deployer.WebServer.demoWeb.stop=sh $CATALINA_HOME/bin/shutdown.sh

#################################################
###            NOTIFICATION                  ####
#################################################
MailLogger.failure.to=kar-weng.wong@hpe.com
MailLogger.success.to=kar-weng.wong@hpe.com