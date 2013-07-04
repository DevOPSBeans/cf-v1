# CFv1 DevOPS Beans

Scripts & things to our CFv1 Implement

* Ruby Version installed

```
$ ruby --version
ruby 1.9.2p180 (2011-02-18 revision 30909) [x86_64-linux]
```

### Configuración _"prueba"_ de [god][1]

* We have created this [script][2] to start/stop CFv1.
* We have dived into services' config files to see the real path of its pids files, info that we need to config god.

```
$ grep pid /home/sistemas/cloudfoundry/.deployments/devbox/config/*_node.yml 
/home/sistemas/cloudfoundry/.deployments/devbox/config/mongodb_node.yml:pid: /var/vcap/sys/run/mongodb_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/mysql_node.yml:pid: /var/vcap/sys/run/mysql_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/neo4j_node.yml:pid: /var/vcap/sys/run/neo4j_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/postgresql_node.yml:pid: /var/vcap/sys/run/postgresql_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/rabbitmq_node.yml:pid: /var/vcap/sys/run/rabbit_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/redis_node.yml:pid: /var/vcap/sys/run/redis_node.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/vblob_node.yml:pid: /var/vcap/sys/run/vblob_node.pid

$ grep pid /home/sistemas/cloudfoundry/.deployments/devbox/config/*_gateway.yml 
/home/sistemas/cloudfoundry/.deployments/devbox/config/mongodb_gateway.yml:pid: /var/vcap/sys/run/mongodb_service.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/mysql_gateway.yml:pid: /var/vcap/sys/run/mysql_service.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/neo4j_gateway.yml:pid: /var/vcap/sys/run/neo4j_service.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/postgresql_gateway.yml:pid: /var/vcap/sys/run/postgresql_service.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/rabbitmq_gateway.yml:pid: /var/vcap/sys/run/rabbit_gateway.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/redis_gateway.yml:pid: /var/vcap/sys/run/redis_service.pid
/home/sistemas/cloudfoundry/.deployments/devbox/config/vblob_gateway.yml:pid: /var/vcap/sys/run/vblob_service.pid
```

> *Conclusion*: 



[1]: http://godrb.com/
[2]: https://github.com/DevOPSBeans/cf-v1/blob/master/vcap.sh
