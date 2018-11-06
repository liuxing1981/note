# Authorization Modules 授权模块

* Node
* ABAC
* RBAC
* Webhook

```
     #启动apiserver时指定用何种方式授权
     kube-apiserver --authorization-mode=RBAC
```

### 查看权限　**kubectl auth can-i**
```
    #查看当前用户是否有在namespace dev 下创建deployment的权限
    kubectl auth can-i create deployments --namespace dev
    
    #用as查看其他用户的权限
    kubectl auth can-i list secrets --namespace dev --as dave

```

