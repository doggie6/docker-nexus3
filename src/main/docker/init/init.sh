#!/usr/bin/env bash

#初始化工作 0.创建部署账号 1. 创建docker相关仓库 2. npm仓库 //TODO

#https://books.sonatype.com/nexus-book/reference3/scripting.html

#0

if type -p waitforit > /dev/null; then
   #  -debug
   waitforit -full-connection=tcp://127.0.0.1:8081 -timeout=180
   echo "nexus_running: --------------------------------------------"
   if [ $? -gt 0 ]; then
         echo "nexus is not running"
         exit 1
    fi
fi

cd init/json/
for json in `ls`
do
    echo ++++++++++++++++++++++++++add ${json}++++++++++++++++++++
    bash ../create.sh ${json}
    echo ++++++++++++++++++++++++++run ${json%%.*}++++++++++++++++
    bash ../run.sh ${json%%.*}
done
cd -
#1



#2

