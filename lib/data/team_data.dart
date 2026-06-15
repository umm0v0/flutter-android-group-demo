import "package:flutter/material.dart";
import "package:group_flutter_pages_demo/models/team_member.dart";
import "package:group_flutter_pages_demo/models/project_feature.dart";
import "package:group_flutter_pages_demo/models/release_note.dart";
import "package:group_flutter_pages_demo/models/experiment_task.dart";

/// 3 块独立数据，分布给 3 名组员各自修改。
/// 组员只需要修改自己负责的方法，互不冲突。

class TeamData {
  TeamData._();

  // ────────────────────────────────────────────
  // 温道庚（组长）负责：项目标题、口号、实验概述
  // ────────────────────────────────────────────
  static String get projectTitle => "Flutter 小组 · Android 真机运行展示";

  static String get projectSlogan =>
      "GitHub 多人协作 · Flutter 移动应用 · Android 真机部署实践";

  static String get experimentOverview =>
      "本项目是移动应用实训课程第15周实践项目。"
      "3人小组通过 GitHub Fork + Branch + Pull Request 流程协作开发 Flutter 应用，"
      "最终部署到真实 Android 手机（OPPO K12x 5G）上运行，"
      "并使用第二部手机手持拍摄真机运行画面作为证据提交。";

  // ────────────────────────────────────────────
  // 李炎彬（组员）负责：成员列表
  // ────────────────────────────────────────────
  static List<TeamMember> get members => const [
        TeamMember(
          id: "wendao",
          name: "温道庚",
          role: "组长",
          task: "项目脚手架搭建、首页与证据页开发、PR审核、真机测试",
          bio: "云南大学 2024级 计算机科学与技术。Java后端方向。"
              "已学完MySQL、JavaWeb、SSM、Redis、Spring Cloud、Docker、RabbitMQ、Elasticsearch。"
              "力扣200题，GitHub协作经验丰富。",
          skills: ["Java", "Spring Cloud", "Redis", "MySQL", "Docker", "RabbitMQ", "Flutter", "Git"],
          avatarUrl: "",
          githubUrl: "https://github.com/umm0v0",
        ),
        TeamMember(
          id: "liyanbin",
          name: "李炎彬",
          role: "组员",
          task: "小组成员卡片页、实验任务列表页、README文档完善",
          bio: "云南大学 2024级 计算机科学与技术。"
              "熟悉C/C++、FPGA数字逻辑设计（Vivado/Quartus），"
              "已完成单周期MIPS CPU设计与74系列数字逻辑实验。"
              "掌握Flutter移动端开发，参与大创项目「安鑫e伴」（反诈骗方向）。",
          skills: ["C/C++", "FPGA", "Flutter", "Android", "Git", "Java"],
          avatarUrl: "",
          githubUrl: "https://github.com/liyanbin2006",
        ),
        TeamMember(
          id: "huchengrui",
          name: "胡城瑞",
          role: "组员",
          task: "测试设备信息页、环境配置说明、运行证据整理",
          bio: "云南大学 2024级 计算机科学与技术。"
              "具备扎实的编程基础，熟悉Python与计算机组成原理。"
              "对Android系统调试与移动端测试有实践经验。
              熟练使用Flutter",
          skills: ["Python", "Android", "ADB", "Git", "Linux","Flutter"],
          avatarUrl: "",
          githubUrl: "https://github.com/a5077",
        ),
      ];

  // ────────────────────────────────────────────
  // 胡城瑞（组员）负责：实验任务列表
  // ────────────────────────────────────────────
  static List<ExperimentTask> get tasks => const [
        ExperimentTask(
          title: "GitHub 仓库创建与初始化",
          description: "组长创建原始仓库，配置 .gitignore、README 等项目基础文件",
          assignee: "温道庚",
          status: TaskStatus.completed,
        ),
        ExperimentTask(
          title: "Flutter 项目脚手架搭建",
          description: "配置 Flutter Android 项目结构，引入 go_router、riverpod 依赖",
          assignee: "温道庚",
          status: TaskStatus.completed,
        ),
        ExperimentTask(
          title: "成员 Fork 与分支开发",
          description: "组员 Fork 仓库后创建特性分支，各自完成分配的页面开发任务",
          assignee: "李炎彬",
          status: TaskStatus.completed,
        ),
        ExperimentTask(
          title: "Pull Request 提交与代码审核",
          description: "组员提交 PR，组长进行代码 Review 并提出修改意见",
          assignee: "温道庚",
          status: TaskStatus.completed,
        ),
        ExperimentTask(
          title: "Android 真机调试配置",
          description: "配置开发者选项、USB调试，连接真实手机进行应用测试",
          assignee: "胡城瑞",
          status: TaskStatus.completed,
        ),
        ExperimentTask(
          title: "真机运行证据采集",
          description: "使用第二部手机手持拍摄真机运行界面，确保证据清晰可辨",
          assignee: "胡城瑞",
          status: TaskStatus.completed,
        ),
      ];

  // ────────────────────────────────────────────
  // 温道庚（组长）负责：项目功能列表
  // ────────────────────────────────────────────
  static List<ProjectFeature> get features => const [
        ProjectFeature(
          icon: Icons.phone_android,
          title: "Flutter Android 应用",
          description: "基于 Material Design 3 的移动应用，底部导航4Tab结构，支持亮色/暗色主题切换",
          color: Color(0xFF6366F1),
        ),
        ProjectFeature(
          icon: Icons.account_tree,
          title: "Git 分支协作",
          description: "多人 Fork + 多分支并行开发，Pull Request 代码审查，模拟真实团队工作流",
          color: Color(0xFF06B6D4),
        ),
        ProjectFeature(
          icon: Icons.merge_type,
          title: "PR 审核合并",
          description: "GitHub Pull Request 创建、代码审查、冲突解决与合并策略实践",
          color: Color(0xFF8B5CF6),
        ),
        ProjectFeature(
          icon: Icons.developer_mode,
          title: "Android 真机部署",
          description: "通过 ADB 连接真实手机，flutter run 部署到 OPPO K12x 5G 真机运行",
          color: Color(0xFFF59E0B),
        ),
        ProjectFeature(
          icon: Icons.camera_alt,
          title: "手持拍摄证据",
          description: "使用第二部手机手持拍摄真机运行界面，符合课程证据标准要求",
          color: Color(0xFF10B981),
        ),
      ];

  // ────────────────────────────────────────────
  // 李炎彬（组员）负责：发布说明
  // ────────────────────────────────────────────
  static List<ReleaseNote> get releaseNotes => const [
        ReleaseNote(
          version: "v1.0.0",
          date: "2026-06-15",
          title: "项目初始化与架构搭建",
          description: "完成 Flutter Android 应用基础架构搭建。"
              "底部导航4个Tab：首页实验概述、小组成员展示、实验任务列表、运行证据说明。"
              "支持 Material Design 3 亮暗主题切换。",
          type: ReleaseNoteType.release,
        ),
        ReleaseNote(
          version: "v1.0.1",
          date: "2026-06-16",
          title: "成员数据与任务完善",
          description: "补充3人小组成员信息（温道庚、李炎彬、胡城瑞），"
              "李炎彬完成成员卡片页与发布说明数据填充。"
              "完善实验任务分工列表，添加完成状态标识与负责人信息。",
          type: ReleaseNoteType.deploy,
        ),
        ReleaseNote(
          version: "v1.0.2",
          date: "2026-06-17",
          title: "Android 真机适配与测试",
          description: "配置 Android 构建环境，添加设备信息页面。"
              "完成真机运行测试并采集4张手持拍摄证据照片。",
          type: ReleaseNoteType.release,
        ),
      ];
}
