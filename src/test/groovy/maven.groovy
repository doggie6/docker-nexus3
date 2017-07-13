//docker-repo
repository.createDockerHosted("docker-repo",5000,null)

//docker-hub
repository.createDockerProxy("docker-hub","https://index.docker.io/","HUB",null,null,null)

//docker-163
repository.createDockerProxy("docker-163","http://hub-mirror.c.163.com","HUB",null,null,null)

//docker-public
repository.createDockerGroup("docker-public",5001,null,["docker-hub","docker-163","docker-repo"])