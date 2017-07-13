#!/usr/bin/env bash

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
echo ______________________${scripts}_________________________-

if [ "$scripts" != "[ ]" ]; then
    echo "不是首次启动容器，不进行初始化操作"
    exit;
fi

cd init/json/


#0

#bash ../delete.sh docker-163
#bash ../delete.sh docker-hub
#bash ../delete.sh docker-repo
#bash ../delete.sh docker-public

bash ../create.sh docker-163.json
bash ../create.sh docker-hub.json
bash ../create.sh docker-repo.json
bash ../create.sh docker-public.json


bash ../run.sh docker-163
bash ../run.sh docker-hub
bash ../run.sh docker-repo
bash ../run.sh docker-public

#1

bash ../create.sh role-deploy.json
bash ../create.sh user-deploy.json

bash ../run.sh role-deploy
bash ../run.sh user-deploy

#2

cd -