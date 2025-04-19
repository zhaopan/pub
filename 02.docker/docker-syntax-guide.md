# docker-syntax-guide

compose.yml 和 Dockerfile 的语法规则容易混淆，尤其是 `=` 和 `:` 的使用场景。以下是 终极总结，涵盖所有常见场景和易错点，帮你彻底避坑！

## 一、核心规则速查表

| 文件/场景               | 符号 | 示例                     | 规则说明                  |
|------------------------|------|--------------------------|-------------------------|
| **Dockerfile ENV**     | `=`  | `ENV KEY=value`          | 必须用 `=` |
| **Dockerfile ARG**     | `=`  | `ARG VERSION=1.0`        | 默认值用 `=` |
| **Compose environment** (列表) | `=`  | `- KEY=value`          | 列表项字符串格式         |
| **Compose environment** (映射) | `:`  | `KEY: value`           | YAML 键值对 |
| **Compose args**       | `:`  | `VERSION: ${VER}`      | 必须用 `:` |
| **Compose ports**      | `:`  | `- "8080:80"`          | 端口映射 |
| **Compose volumes**    | `:`  | `- /host:/container`   | 路径映射 |
| **Compose labels**     | `:`  | `label: "value"`       | YAML 键值对 |

---

## 二、Dockerfile 中的符号规则

### `=` 的使用场景

- **`ENV` 环境变量**

  ```dockerfile
  ENV APP_VERSION=1.0.0    # 必须用 =
  ENV DB_HOST=db
  ```

- **`ARG` 构建参数默认值**

  ```dockerfile
  ARG USER=admin           # 定义默认值用 =
  ```

### `:` 的使用场景

- LABEL 标签

  ```dockerfile
  LABEL maintainer="me@example.com"  # 值中有空格时用引号
  ```

## 三、docker-compose.yml 中的符号规则

### `=` 的使用场景

- environment 的列表格式

  ```yml
  environment:
  - DB_HOST=db         # 必须用 =
  - REDIS_URL=redis://cache
  ```

### `:` 的使用场景

|字段|示例|说明|
|:--|:--|:--|
|`environment` 映射格式|`DB_HOST: db`|替代 `- DB_HOST=db` 的写法|
|`args`|`APP_VERSION: ${VERSION}`|构建参数必须用 `:`|
|`ports`|`- "8080:80"`|端口映射必须用 `:`|
|`volumes`|`- ./data:/app/data`|路径映射必须用 `:`|

## 四、高频易错点

### 1. 混淆 `environment` 的两种格式

```yml
# ✅ 正确
environment:
  - KEY=VALUE    # 列表格式，用 =
  KEY: VALUE     # 映射格式，用 :

# ❌ 错误
environment:
  KEY=VALUE      # 映射格式漏了 :
  - KEY: VALUE   # 列表格式误用 :
```

### 2. 误用 `=` 代替 `:`

```yml
# ❌ 错误
volumes:
  - /host=/container   # 必须用 :
ports:
  - "8080=80"          # 必须用 :
```

## 五、调试技巧

### 验证语法

```bash
docker-compose config  # 检查 compose 文件合法性
docker build .         # 检查 Dockerfile 语法
```

### 查看生效值

```bash
docker inspect <容器ID>  # 查看实际环境变量/挂载/端口
```

## 六、总结

- `=`：仅用于 `Dockerfile` 的 `ENV/ARG` 和 `compose` 的 `environment` 列表格式
- `:`：用于所有 路径映射（`ports`/`volumes`）和 `YAML` 键值对（`args`/`labels`）
- 变量 `${VAR}`：两种符号下均支持，但需确保变量已定义。
