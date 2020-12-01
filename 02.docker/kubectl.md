# kubectl

## kubectl remark

```bash
# 查看所有 pod 列表,  -n 后跟 namespace, 查看指定的命名空间
kubectl get nodes
kubectl get pod
kubectl get pods -n kube-system
ps -ef | grep kubelet

# 查看 RC 和 service 列表， -o wide 查看详细信息
kubectl get rc,svc
kubectl get pod,svc -o wide
kubectl get pod <pod-name> -o yaml

kubectl edit deployment/tjbb-weikebaba-com -n default

kubectl describe pods tjbb-weikebaba-com-d594ccc98-658jz | tail
# 查看 endpoint 列表
kubectl get endpoints
kubectl get namespace
kubectl get deployment

# 显示 Node 的详细信息
kubectl describe node 192.168.0.212

# 显示 Pod 的详细信息, 特别是查看 pod 无法创建的时候的日志
kubectl describe pod <pod-name>
eg:
kubectl describe pod redis-master-tqds9

# 根据 yaml 创建资源, apply 可以重复执行，create 不行
kubectl create -f pod.yaml
kubectl apply -f pod.yaml

# 基于 pod.yaml 定义的名称删除 pod
kubectl delete -f pod.yaml

# 删除所有包含某个 label 的pod 和 service
kubectl delete pod,svc -l name=<label-name>

kubectl delete namespace xxx

# 编辑
kubectl edit {deploy}/{deployname} -n {namespacename}
eg:
kubectl edit deployment/nginx -n default

# 删除所有 Pod
kubectl delete pod --all

# 执行 pod 的 date 命令
kubectl exec <pod-name> -- date
kubectl exec <pod-name> -- bash
eg:
kubectl exec spdweb-6b7c5dbc6-hkg9c -- ping 10.24.51.9

# 通过bash获得 pod 中某个容器的TTY，相当于登录容器
kubectl exec -it <pod-name> -c <container-name> -- bash
eg:
kubectl exec -it redis-master-cln81 -- bash

# 查看容器的日志
kubectl logs <pod-name>
kubectl logs -f <pod-name> # 实时查看日志

# 容器日志输出到文件
eg:
log_pod release-xxxx 10000 > xxxx.txt
```

## K8s安装步骤

### 常用命令

```bash
#查看当前yum里面的Kubernetes版本
yum info kubernetes

#查看docker版本号
docker --version

#查看docker镜像
docker images  或者docer image ls

#查看pod实例分配的IP地址
kubectl get pods -o wide

#查看Kubetnetes里面的service
kubectl get svc

#查看状态
kubectl get pods --all-namespaces

#查看service
kubectl --namespace=kube-system get deployment kubernetes-dashboard
kubectl --namespace=kube-system get service kubernetes-dashboard

#获取nodes节点
kubectl get nodes
kubectl get pods --namespace=kube-system
kubectl get pods --all-namespaces

#查询故障信息
kubectl get pods -n kube-system |grep -v Running
kubectl describe pod kubernetes-dashboard-5c469b58b8-bltsw -n kube-system

#升级集群到新的版本
kubeadm upgrage
kubeadm reset
#管理token
kubeadm token
#版本
kubeadm version

#查看状态
systemctl status kubelet

kubectl get pods --namespace=kube-system

kubectl get pods -n kube-system |grep -v Running

kubectl describe pod kubernetes-dashboard-5c469b58b8-bltsw -n kube-system
```

### 1.查看版本号

```bash
# cat /etc/redhat-release
CentOS Linux release 7.5.1804 (Core)
# uname -r
3.10.0-862.9.1.el7.x86_64
```

### 2.设置主机名称\(非必须\)

```bash
hostnamectl set-hostname DowayDocker
```

### 3.准备环境

```bash
# 关闭防火墙
$ systemctl stop firewalld
$ systemctl disable firewalld

# 关闭selinux
$ sed -i 's/enforcing/disabled/' /etc/selinux/config
$ setenforce 0

# 关闭swap
$ swapoff -a  $ 临时
$ vim /etc/fstab  $ 永久

# 关闭swap：(方式二)
swapoff -a
echo "vm.swappiness = 0">> /etc/sysctl.conf
sysctl -p

# 将桥接的IPv4流量传递到iptables的链：
$ cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
$ sysctl --system
# 加载内核模块
modprobe br_netfilter
lsmod | grep br_netfilter
```

### 4.所有节点安琥藏Docker/kubeadm/kubelet

```bash
Kubernetes默认CRI（容器运行时）为Docker，因此先安装Docker。
```

### 5.设置yum源\(Docker-18.6 K8S-1.14.0\)

```bash
# base repo
cd /etc/yum.repos.d
mv CentOS-Base.repo CentOS-Base.repo.bak
curl -o CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/CentOS-Base.repo

# docker repo
curl -o docker-ce.repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# k8s repo
cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# update cache
yum clean all
yum makecache
yum repolist
```

### 6.安装Docker\(最好指定版本号\)

```bash
# 安装Docker
yum install docker-ce-18.06.3.ce

# 启动docker
systemctl enable docker --now

# 查看docker状态
systemctl status docker
```

### 7.安装kubeadm，kubelet和kubectl\(指定版本号\)

```bash
# 安装kubeadm，kubelet和kubectl
$ yum install -y kubelet-1.14.0 kubeadm-1.14.0 kubectl-1.14.0
$ systemctl enable kubelet
```

### 8.部署Kubernetes Master

```bash
kubeadm init \
  --apiserver-advertise-address=172.19.91.28 \
  --image-repository registry.aliyuncs.com/google_containers \
  --kubernetes-version v1.14.0 \
  --service-cidr=10.1.0.0/16 \
  --pod-network-cidr=10.244.0.0/16\
  --ignore-preflight-errors=NumCPU

# 阿里云

kubeadm join xxxx:6443 --token fw6wss.b62mldqm4yvee1pu \
    --discovery-token-ca-cert-hash sha256:d8ee827fcb07aa69647a7436f370781249a3d1a08b226be0d210cfd3ac216bd6

#加载环境变量
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

### 9.安装网络插件

```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml
```

### 10.部署Dashboard

```bash
# 下载kubernetes-dashboard.yaml文件

# 下载yaml文件
wget https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
修改kubernetes-dashboard.yaml

# 替换images
containers:
      - name: kubernetes-dashboard
        #image: k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
        image: lizhenliang/kubernetes-dashboard-amd64:v1.10.1#新增

kind: Service
apiVersion: v1
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kube-system
spec:
  type: NodePort #新增
  ports:
    - port: 443
      targetPort: 8443
      nodePort: 30001 #新增
  selector:
    k8s-app: kubernetes-dashboard

# 创建Dashboard

kubectl apply -f kubernetes-dashboard.yaml  #创建dashboard
https://<ip地址>:<端口号port>访问dashboard地址

# 获取Token
kubectl create serviceaccount dashboard-admin -n kube-system

kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --\
serviceaccount=kube-system:dashboard-admin

kubectl describe secrets -n kube-system $(kubectl -n kube-system get secret | awk '/dashboard-admin/{print $1}')
# 通过token登陆
```

### 11 Pod调度到Master节点

```bash
# 1.如何将Master也当作Node使用
kubectl taint node master node-role.kubernetes.io/master-

# 2.将Master恢复成Master Only状态
kubectl taint node master node-role.kubernetes.io/master="":NoSchedule
```

