# k8s-mongodb-cluster

## 为什么要提供该项目
因工作需求，需要使用K8s部署生产环境级带密码验证的MongoDB集群，然而参考了网上众多资料均因各种原因失败，如要么MongoDB版本太低、要么密码配置无效、要么集群认证失败等。经过无数次采坑终成功，欣喜之余索性放在GitHub上，供需要的朋友使用或完善。

## 如何使用
首先，基于社区MongoDB镜像，定制化镜像，用于集群key认证
生成keyfile
```
openssl rand -base64 741 > mongodb-keyfile
```

构建镜像
```
docker build -t $youer-registery-address/mongodb:4.1.7 .
```

使用K8s部署一主多从三个副本的MongoDB集群，并使用阿里云的NAS存储实现数据持久化存储。您也可以根据自己实际环境，修改即可
```
kubectl apply -f statefulset.yaml
kubectl apply -f service.yaml
```

## 验证
```
kubectl get pods -n infra | grep mongo
mongo-prod-0                    2/2     Running   0          3h55m
mongo-prod-1                    2/2     Running   0          3h55m
mongo-prod-2                    2/2     Running   0          3h54m


kubectl exec -it mongo-prod-0 -c mongo-prod -n infra bash
root@mongo-prod-0:/# mongo admin -u "admin" -p "123456"
rs0:PRIMARY> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
```

