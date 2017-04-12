#!/bin/bash

export JAVA_HOME=/opt/builds/jdk1.6.0_45/

../apache-ant-1.9.1/bin/ant -f $* -Dsvnkit.symlinks=false
