# archive.sh

> 一个用 Bash 编写的目录归档小工具：把指定目录打包成带日期的 `.tar.gz`。

[![Shell](https://img.shields.io/badge/shell-bash-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## 简介

`archive.sh` 用于把任意目录快速归档为 `tar.gz` 压缩包，文件名自动附带日期，方便按天备份与回溯。

## 功能

- 参数校验：必须且只能传入一个目录
- 目录校验：路径不存在或不是目录时立即退出
- 自动时间戳：`archive_<目录名>_<YYYYMMDD>.tar.gz`
- 自动创建输出目录
- 明确的退出码，便于脚本或 CI 判断结果

## 环境要求

- Linux / macOS（Windows 可用 WSL 或 Git Bash）
- Bash 4.0+
- `tar`（支持 gzip，GNU tar 或 bsdtar 均可）

## 安装

```bash
git clone https://github.com/<your-name>/archive-script.git
cd archive-script
chmod +x archive.sh
```

## 使用方法

```bash
./archive.sh <目录路径>
```

示例：

```bash
./archive.sh /home/root/downloads
```

输出：

```
Parameter inputed successfully
Operating now
Operating successfully
Operating file_name: /archive/archive_downloads_20261027.tar.gz
```

## 输出

默认写入 `/archive`：

```
/archive/archive_<目录名>_<YYYYMMDD>.tar.gz
```

压缩包内保留目录本身，解压后得到 `<目录名>/...`，不会包含绝对路径。

## 退出码

| 退出码 | 含义 |
|---|---|
| 0 | 归档成功 |
| 1 | 参数缺失、目录不存在或打包失败 |

## 配置

输出目录由脚本中的变量控制，按需修改：

```bash
DEST_DIR=/archive          # 改成 $HOME/archive 即可免 root 运行
```

脚本内已做 `mkdir -p`，目标目录不存在会自动创建。

## 定时归档（可选）

配合 crontab 每天凌晨 2 点归档一次：

```cron
0 2 * * * /<根目录>/archive.sh /<根目录>/downloads >> /var/log/archive.log 2>&1
```

## 常见问题

**Q：提示 `Permission denied` / `权限不够`？**

A：脚本没有执行权限，执行 `chmod +x archive.sh`。若加了仍然报错，检查所在分区是否以 `noexec` 挂载。

**Q：提示 `tar: 无法 open: 没有那个文件或目录`？**

A：输出目录不存在或当前用户无写权限，执行 `mkdir -p /archive`，或用 root 运行。

**Q：同一天多次归档会覆盖吗？**

A：默认按天命名，会覆盖。需要保留多次，把时间格式改为 `%Y%m%d_%H%M%S`。

## 目录结构

```
archive-script/
├── archive.sh
├── README.md
└── .gitattributes
```

## License

[MIT](LICENSE)