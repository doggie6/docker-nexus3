#!/usr/bin/env bash

# 判断 $1 是否包含 $2
function isContains()
{
   if [[ $1 =~ $2 ]]
   then
     return 0
   else
     return 1
   fi
}

#初始化工作 0.创建部署账号 1. 创建docker相关仓库 2. npm仓库 //TODO

#https://books.sonatype.com/nexus-book/reference3/scripting.html

if type -p waitforit > /dev/null; then
   #  -debug
   waitforit -full-connection=tcp://127.0.0.1:8081 -timeout=180
   echo "nexus_running: --------------------------------------------"
   if [ $? -gt 0 ]; then
         echo "nexus is not running"
         exit 1
    fi
fi

# 这里有些问题没解决，所发现的问题 1.run操作重复运行会报错，因为库已经建好了 2.delete操作只能删除script，并不能删除已经建好的库。以上两个问题造成无法用合适的方式来更新
# 暂定若要更新 需进容器手动将所有脚本删除，并进后台将所有库删掉
scripts=`curl -u admin:admin123 'http://127.0.0.1:8081/service/siesta/rest/v1/script'`
scripts=`echo ${scripts} | sed s/[[:space:]]//g`
echo ______________________${scripts}_________________________-

cd init/json/


#0

for json in docker-163 docker-hub docker-repo docker-public
do
  isContains ${scripts} "\"${json}\""
  if [ $? != 0 ]
    then
    bash ../create.sh ${json}.json
    bash ../run.sh ${json}
  fi
done

#1

for json in role-deploy user-deploy
do
  isContains ${scripts} "\"${json}\""
  if [ $? != 0 ]
    then
    bash ../create.sh ${json}.json
    bash ../run.sh ${json}
  fi
done

#2

cd -