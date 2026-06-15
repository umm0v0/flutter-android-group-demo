# 小组 Flutter Android 真机运行展示项目

## 项目简介

本项目是移动应用实训课程第15周实践项目，旨在通过 **GitHub 多人协作** 方式，完成一个 Flutter 应用的开发，并成功部署到真实的 Android 手机上运行。

## 实验目标

| 目标类型 | 描述 |
|----------|------|
| 协作目标 | 掌握 GitHub Fork + Pull Request 协作流程 |
| 技术目标 | 熟悉 Flutter 开发环境配置与 Android 真机调试 |
| 验证目标 | 通过真机运行照片证明协作成果的真实性 |

## 小组成员

| 序号 | 角色 | 姓名 | 分工任务 | 完成状态 |
|------|------|------|----------|----------|
| 1 | 组长 | 温道庚 | 项目脚手架搭建、首页与证据页开发、PR审核、真机测试 | 已完成 |
| 2 | 组员 | 李炎彬 | 小组成员卡片页、实验任务列表页、README文档完善 | 已完成 |
| 3 | 组员 | 胡城瑞 | 测试设备信息页、环境配置说明、运行证据整理 | 已完成 |

## 技术栈

| 分类 | 技术 | 版本要求 |
|------|------|----------|
| 框架 | Flutter | ^3.12.0 |
| 语言 | Dart | ^3.4.0 |
| 状态管理 | flutter_riverpod | ^2.6.1 |
| 路由 | go_router | ^15.1.2 |
| 主题 | Material Design 3 | 亮/暗主题切换 |
| 版本控制 | Git / GitHub | - |
| 移动平台 | Android | API 24+ |

## 项目结构

```
lib/
├── main.dart                     # 入口
├── app.dart                      # MaterialApp.router
├── core/
│   ├── theme/                    # 亮/暗主题、色板、字体体系
│   ├── router/                   # GoRouter 路由配置 (ShellRoute 底部导航)
│   └── constants/                # 应用常量
├── models/                       # 数据模型 (TeamMember, ExperimentTask, ProjectFeature, ReleaseNote)
├── data/
│   ├── team_data.dart            # 3块独立数据，组员各自修改
│   └── repositories/             # Repository 模式
├── features/
│   ├── home/                     # 首页：实验概述
│   ├── members/                  # 小组成员卡片页
│   ├── tasks/                    # 实验任务列表页
│   └── evidence/                 # 运行证据页
└── shared/widgets/               # 共享组件 (毛玻璃卡片、技能标签、响应式容器)
```

## 页面说明

| 路由 | 页面 | Tab | 说明 |
|------|------|-----|------|
| `/` | 首页 | 1 | Hero 波浪动画 + 实验概述 + 项目功能 |
| `/members` | 小组成员 | 2 | 3人卡片展示 + 协作说明 |
| `/tasks` | 实验任务 | 3 | 6个任务项 + 完成状态 + 负责人 |
| `/evidence` | 运行证据 | 4 | 设备信息 + 照片区域 + 证据标准 |
| `/members/:id` | 成员详情 | - | 头像、技能标签、分工任务 |
| `/roadmap` | 项目路线图 | - | 版本迭代时间线 |

## 测试设备信息

| 参数 | 详情 |
|------|------|
| 设备名称 | OPPO K12x 5G |
| 操作系统 | ColorOS 15.0 (Android 15) |
| 处理器 | 高通骁龙 695 5G 八核 |
| 运行内存 | 12.0 GB + 12.0 GB |
| 存储空间 | 256 GB |
| 屏幕 | 6.72英寸 2400x1080 FHD+ |

## 环境要求

| 软件 | 版本要求 | 说明 |
|------|----------|------|
| Flutter SDK | >= 3.12.0 | 官方稳定版 |
| Dart SDK | >= 3.4.0 | Flutter 内置 |
| Android Studio | >= Hedgehog | 推荐版本 |
| JDK | >= 17 | 开发工具包 |
| Android SDK | >= API 24 | 目标平台版本 |

## 本地运行

```bash
# 克隆项目
git clone git@github.com:umm0v0/-group-flutter-pages-demo.git
cd -group-flutter-pages-demo

# 安装依赖
flutter pub get

# 连接真机后运行
flutter run

# 构建 APK
flutter build apk --release
```

## GitHub 协作流程

### Fork 流程

1. 访问原始仓库
2. 点击右上角 Fork 按钮
3. 等待 Fork 完成，进入个人仓库

### 本地开发

```bash
git clone git@github.com:<your-username>/-group-flutter-pages-demo.git
cd -group-flutter-pages-demo
git remote add upstream git@github.com:umm0v0/-group-flutter-pages-demo.git
git checkout -b feature/<your-feature>
# 开发完成后
git add .
git commit -m "feat: XXX功能"
git push origin feature/<your-feature>
```

### Pull Request 流程

1. 访问个人仓库 GitHub 页面
2. 切换到已推送的特性分支
3. 点击 Compare & pull request
4. 填写 PR 标题和描述
5. 指定组长(umm0v0)作为审核人
6. 提交 PR 等待审核

## 实验证据说明

### 证据要求

| 要求 | 说明 | 是否符合 |
|------|------|----------|
| 禁止 Web 截图 | 不能提交浏览器或网页截图 | 是 |
| 禁止模拟器截图 | 必须使用真实设备 | 是 |
| 禁止手机截图 | 不能使用手机自带截图功能 | 是 |
| 必须手持拍摄 | 使用第二部手机拍摄手持真机的照片 | 是 |
| 清晰展示界面 | 照片需清晰显示应用运行界面 | 是 |

### 真机运行照片

| 照片编号 | 场景说明 |
|----------|----------|
| 照片1 | 应用启动页面展示 |
| 照片2 | 实验概述页面展示 |
| 照片3 | 小组成员列表展示 |
| 照片4 | 实验任务列表展示 |

### 照片存放路径
照片存放于项目根目录 `images/` 文件夹中。

## 交付物清单

| 交付物 | 状态 | 说明 |
|--------|------|------|
| GitHub 主仓库 | 已完成 | 包含完整协作历史 |
| Fork 记录 | 已完成 | 3人完整 Fork 记录 |
| 分支记录 | 已完成 | 每人至少一条特性分支 |
| Commit 记录 | 已完成 | 完整的代码提交历史 |
| Pull Request | 已完成 | 每人至少一个 PR |
| 合并记录 | 已完成 | 所有 PR 已合并到 main |
| 真机运行照片 | 待采集 | 4张手持真机照片 |
| README 文档 | 已完成 | 包含证据说明 |

---

*项目完成日期：2026年6月*
*课程：移动应用实训第15周*
