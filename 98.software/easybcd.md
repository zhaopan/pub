# easybcd | EasyBCD 引导配置实战手册

本文件为 Windows + Linux 双系统引导配置的详细操作记录，基于 EasyBCD 工具，涵盖：

- ✅ 系统识别与引导项配置
- ✅ GRUB2 添加方式与引导优先级设置
- ✅ BCD 导出备份与恢复策略
- ✅ 曾遇到的引导混乱、重装误引导修复经验

---

## 📁 软件概览

- 工具名称：EasyBCD
- 官网：<https://neosmart.net/EasyBCD>
- 用途：Windows 系统下修改 BCD 引导配置，支持添加 Linux / GRUB 系统

---

## 🧩 常见操作步骤

### 添加 Linux 系统引导（GRUB2）

1. 打开 EasyBCD → Add New Entry
2. 选择 "Linux/BSD"
3. Type 选择 **GRUB2**
4. Name 输入如 "Ubuntu 22.04"
5. Device 指定为 Linux 所在分区（如 D:\ 或 Linux 根分区）

> 🧠 注意：有时 Device 显示为“自动”，实际指向可能不正确，建议用 DiskGenius 等工具确认 Linux 所在分区编号

---

## 🧪 实战经验：Windows 覆盖引导恢复 Linux

背景：

- 安装完 Linux 后引导正常
- 后重装 Windows 导致原 GRUB 引导被覆盖
- 使用 EasyBCD 重新挂载 GRUB2 恢复

处理方式：

```bash
bcdedit /set {bootmgr} path \EFI\ubuntu\grubx64.efi
```

或：

- 通过 EasyBCD 添加新 GRUB2 引导项并设为默认

---

## 🛠️ 常见问题与排查建议

| 问题场景               | 原因                 | 解决方案                           |
| ---------------------- | -------------------- | ---------------------------------- |
| 引导项无效             | Device 分区错误      | 使用分区工具核对 Linux root 分区   |
| 重启后引导丢失         | Windows 自动修复引导 | 用 EasyBCD 或 bcdedit 重设引导路径 |
| Linux 无法进入图形界面 | GRUB 参数缺失        | 检查 GRUB 默认参数或重装 GRUB      |

---

## 🧠 历史注释与经验积累

- EasyBCD 只修改 Windows BCD，**不会修改 Linux 分区**
- 建议每次添加或修改前备份 BCD 配置：

```bash
bcdedit /export C:\bcd_backup
```

- 误删 GRUB 引导文件建议 LiveCD 进系统后执行：

```bash
grub-install /dev/sda
update-grub
```

> 📁 本文档建议归档在 `/software/full-config/easybcd-deep.md`，用于双系统部署或恢复时查阅。
