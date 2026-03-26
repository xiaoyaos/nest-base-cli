# @nest-base/cli

用于快速初始化基于 `nest-base` 的 NestJS 服务工程。

## 目录说明

```sh
demo-service
├── .ci/                          # GitLab CI 相关目录
│   ├── gitlab_ci                 # 初始化生成的 SSH 私钥
│   ├── gitlab_ci.pub             # 初始化生成的 SSH 公钥
│   └── scripts/                  # GitLab Runner 部署脚本
│       ├── before.sh             # 部署前 SSH 环境准备
│       └── script.sh             # Docker 构建与服务部署
├── .husky/                       # Git hooks 目录
│   └── commit-msg                # commitlint 提交信息校验入口
├── dbml/                         # DBML 模板与示例
│   ├── entity.hbs                # 实体生成模板
│   └── user.dbml                 # 示例 DBML 文件
├── src/
│   ├── entities/                 # `pnpm run dbml:build` 生成的实体目录
│   ├── utils/
│   │   └── CustomExceptionExtend.ts
│   ├── app.module.ts             # 默认模块入口
│   └── main.ts                   # 默认启动入口
├── .dockerignore                 # Docker 构建忽略文件
├── .gitlab-ci.yml                # GitLab CI/CD 配置
├── commitlint.config.js          # commitlint 配置
├── config.local.json             # 本地环境配置
├── config.dev.json               # 开发环境配置
├── config.test.json              # 测试环境配置
├── config.prod.json              # 生产环境配置
├── Dockerfile                    # 服务镜像构建文件
├── docker-compose.yml            # 服务部署 compose 文件
├── package.json                  # 项目依赖与脚本
└── pnpm-lock.yaml                # pnpm 锁文件
```

## 前置要求

```bash
# 安装 Nest CLI
npm install -g @nestjs/cli
```

如果你的环境需要访问内网私有仓库，请先确认当前机器具备对应 Git 与 SSH 访问权限。

## 安装

### 私有库安装

```bash
pnpm install -g git+http://uj.git1.xiaohei123.fun:800/mec/nest-base-cli.git#dev_hejiajun
```

### 本地安装

适合调试当前仓库源码。

方式一：全局软链安装

```bash
cd /path/to/nest-base-cli
npm link
```
安装完成后可通过下面命令确认：

```bash
nest-base --help
```

## 使用教程

### 1. 初始化项目

```bash
nest-base demo-service
```

执行完成后会自动完成以下动作：

- 使用 Nest CLI 创建项目
- 安装 `nest-base`、TypeORM、PostgreSQL、Redis、DBML 相关依赖
- 生成默认启动文件与配置模板
- 初始化工程配置文件
- 在生成项目内创建 `.ci/gitlab_ci` SSH 密钥对

### 2. 进入项目

```bash
cd demo-service
```

### 3. 本地启动

```bash
pnpm run start:local
```

开发环境启动：

```bash
pnpm run start:dev
```

### 4. 生成实体模板

```bash
pnpm run dbml:build
```

默认会读取 `dbml/` 目录中的 `.dbml` 文件，并使用 `dbml/entity.hbs` 生成到 `src/entities`。

### 5. Docker 构建与部署

项目初始化后会自带：

- `Dockerfile`
- `docker-compose.yml`
- `.dockerignore`

可结合 CI/CD 脚本或手动执行：

```bash
docker build --ssh default --build-arg NODE_ENV=dev -t demo-service -f ./Dockerfile .
docker compose -p dev up -d
```