import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:group_flutter_pages_demo/data/team_data.dart";
import "package:group_flutter_pages_demo/features/home/widgets/members_section.dart";
import "package:group_flutter_pages_demo/shared/widgets/section_header.dart";

class MembersPage extends ConsumerWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("小组成员"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.people_alt_outlined,
              title: "小组成员",
              subtitle: "本项目由以下成员协作完成",
            ),
            const SizedBox(height: 20),
            MembersSection(members: TeamData.members),
            const SizedBox(height: 40),
            _buildCollaborationInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCollaborationInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withAlpha(60),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                "协作说明",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "3人小组通过 GitHub Fork + Branch + Pull Request 流程完成协作开发。"
            "组长负责仓库创建、脚手架搭建和代码审核；"
            "组员各自 Fork 后创建特性分支完成分配任务，提交 PR 后由组长审核合并。"
            "最终成果部署到 OPPO K12x 5G 真机运行并手持拍摄证据。",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(200),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
