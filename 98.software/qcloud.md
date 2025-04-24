# qcloud | 腾讯云配置使用实战手册

本文件是 `qcloud` 的详细配置与实战使用文档，涵盖：

- ✅ CLI 工具使用
- ✅ 实例管理、快照、磁盘扩容
- ✅ 安全组规则配置与排查
- ✅ 常用命令与故障处理经验

---

## ☁️ 腾讯云 CLI 安装与初始化

```bash
curl -sSL https://cli.qcloud.com/install.sh | bash
tencentcloud configure
```

### 配置项说明

- SecretId / SecretKey
- 默认地域：`ap-shanghai`
- 输出格式：`json`

---

## 🧩 常用命令整理

### 实例相关

```bash
tencentcloud cvm DescribeInstances
tencentcloud cvm StartInstances --InstanceIds xxx
tencentcloud cvm StopInstances --InstanceIds xxx
```

### 镜像管理

```bash
tencentcloud image DescribeImages
tencentcloud image CreateImage --InstanceId xxx
```

### 快照与磁盘

```bash
tencentcloud cbs CreateSnapshot --DiskId xxx
tencentcloud cbs ApplySnapshot --SnapshotId xxx
```

---

## 🔐 安全组配置建议

### 配置示例

```json
{
  "Protocol": "TCP",
  "Port": "22",
  "CidrBlock": "0.0.0.0/0",
  "Action": "ACCEPT",
  "PolicyDescription": "允许远程 SSH"
}
```

> 🧠 建议通过固定 IP + VPN 或跳板机管理，避免开放 0.0.0.0/0

---

## 🧪 实战场景：搭建自动部署流水线

背景：

- 使用 `Qcloud CLI + GitLab Runner` 实现构建完成后远程关机 / 镜像创建
- 避免资源长期空转产生费用

脚本片段：

```bash
tencentcloud cvm StopInstances --InstanceIds $INSTANCE_ID
tencentcloud image CreateImage --InstanceId $INSTANCE_ID --ImageName "build-$(date +%s)"
```

---

## 🛠️ 常见问题与排查建议

| 问题           | 原因                      | 解决方案                    |
| -------------- | ------------------------- | --------------------------- |
| 实例无法连通   | 安全组未开放端口          | 检查 22 / 80 / 443 配置     |
| 镜像创建失败   | 实例未关机                | 确保实例状态为 STOPPED      |
| CLI 报鉴权失败 | SecretKey 错误 / 权限不足 | 使用 `cam` 设置最小权限策略 |

---

## 🧠 历史经验总结

- `DescribeInstances` 可结合 `--Filters` 精确筛选（按标签筛）
- 安全组修改后需等待数秒生效，建议自动脚本中加 `sleep 10`
- 腾讯云后台限制一次最多操作 100 实例，批量需分页操作

> 📁 本文档建议存入 `/software/full-config/qcloud-deep.md`，适用于部署脚本集成与云资源定期巡检。
