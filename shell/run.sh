#!/bin/sh

# This is a little utility script for running the whole NodeRunner process
# during development. It uses maven to create the classpath, then it
# starts the launcher.
# This way you can rebuild and relaunch without any additional steps.

CP=/tmp/cp.$$
rm -f ${CP}

mvn -q -DincludeScope=test -Dmdep.outputFile=${CP} dependency:build-classpath

CLASSPATH=./target/classes:./target/test-classes:`cat ${CP}`
export CLASSPATH
rm ${CP}

#JARGS="-Xmx1g -DSealRoot=false -DOptLevel=1"
#JARGS="-Xdebug -Xrunjdwp:server=y,suspend=y,transport=dt_socket,address=localhost:14000"

exec java ${JARGS} com.apigee.noderunner.shell.Main $*