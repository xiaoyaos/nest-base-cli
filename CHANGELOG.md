# 更新日志（Changelog）

本文件记录项目的所有重要变更。

格式参考 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)
并遵循 [语义化版本控制](https://semver.org/lang/zh-CN/)


## [1.1.0] - 2026-03-26

### 新增
- 为生成项目新增 CI/CD 初始化能力，自动创建 `.ci/scripts`、`.gitlab-ci.yml` 以及部署所需的 SSH 密钥
- 为生成项目新增 Docker 部署模板，自动生成 `Dockerfile`、`docker-compose.yml` 与 `.dockerignore`
- 新增 `commitlint` 与 `husky` 初始化能力，自动写入 `commitlint.config.js`、`.husky/commit-msg` 及对应依赖
- 新增 DBML 工程模板，自动初始化 `dbml/`、`entity.hbs`、示例 `user.dbml` 与 `dbml:build` 构建脚本
- 补充 `config.test.json` 模板，完善多环境配置初始化能力

### 变更
- 将 CI/CD、Docker、commitlint 与 DBML 相关资源统一收敛到模板目录，由 CLI 在创建项目时自动注入
- 将 `nest-base` 私有依赖源统一调整为 `http://uj.git1.xiaohei123.fun:800/`
- 优化 `docker-compose.yml` 与 `.gitlab-ci.yml` 模板生成方式，按项目名动态生成服务名、镜像名和 CI 标签

### 修复
- 修复模板目录在全局安装场景下的定位问题，确保 CLI 可通过真实脚本路径正确复制模板文件
- 修复 DBML 模板的字段映射与关系生成细节，提升生成实体的可用性与稳定性

---
## [1.0.0] - 2026-01-28

### 新增
- 首次发布 `@nest-base/cli`，提供 `nest-base <app-name>` 项目初始化命令
- 基于 Nest CLI 与 `pnpm` 创建项目，并自动安装 `nest-base`、`@nestjs/config`、`nest-winston`、TypeORM、PostgreSQL 和 `ioredis` 等基础依赖
- 生成默认的 `src/main.ts` 与 `src/app.module.ts`，开箱接入 `NestCommonModule`、`AutoConfiguredModule` 与统一启动流程
- 初始化 `config_prod.json`、`config_dev.json`、`config_local.json` 三套配置文件，提供数据库、Redis、OSS、Kafka 与 API Gateway 示例配置

### 变更
- 将应用端口读取方式调整为基于 `ConfigService` 的 `app.port` 配置
- 将初始化配置从 `.env` 方案切换为 JSON 配置文件，统一多环境配置结构
- 补充 README 使用说明，并新增 `.npmignore` 以收敛发布包内容

### 修复
- 修复 CLI 可执行权限问题
- 修复 `nest-base` 依赖源指向错误
- 修复项目初始化时的配置文件生成流程，并优化安装与提示信息

---

## [0.1.0] - 2026-03-20

### 新增
- 基础 Redis 服务
- 初始 docker-compose 配置
