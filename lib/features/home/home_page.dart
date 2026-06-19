import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:group_flutter_pages_demo/data/team_data.dart";
import "package:group_flutter_pages_demo/data/repositories/team_repository.dart";
import "package:group_flutter_pages_demo/data/repositories/team_repository_remote.dart";
import "package:group_flutter_pages_demo/features/home/widgets/hero_section.dart";
import "package:group_flutter_pages_demo/features/home/widgets/features_section.dart";
import "package:group_flutter_pages_demo/shared/widgets/section_header.dart";
import "package:group_flutter_pages_demo/core/theme/app_colors.dart";

final teamDataProvider = FutureProvider<TeamPageData>((ref) async {
  // 优先从 GitHub Raw 远程加载数据，网络异常时自动回退到本地数据源
  final repo = RemoteTeamRepository();
  return repo.getTeamData();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamData = ref.watch(teamDataProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("实验概述"),
        centerTitle: false,
      ),
      body: teamData.when(
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              HeroSection(
                title: data.projectTitle,
                slogan: data.projectSlogan,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      icon: Icons.info_outline,
                      title: "实验说明",
                      subtitle: "移动应用实训课程第15周实践项目",
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.cardDark
                            : AppColors.cardLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant.withAlpha(80),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOverviewItem(
                            context, Icons.flag_outlined, "实验主题",
                            "GitHub 协作与 Flutter Android 真机运行案例",
                          ),
                          const SizedBox(height: 14),
                          _buildOverviewItem(
                            context, Icons.gps_fixed, "核心目标",
                            "证明3人小组确实完成了GitHub多人协作，且Flutter成果成功运行到真实Android手机",
                          ),
                          const SizedBox(height: 14),
                          _buildOverviewItem(
                            context, Icons.schema_outlined, "协作流程",
                            "仓库初始化 → Fork → 分支开发 → PR提交 → 代码审核 → 合并 → 真机运行 → 证据采集",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    const SectionHeader(
                      icon: Icons.star_outline,
                      title: "项目功能",
                      subtitle: "本实验涉及的核心技术模块",
                    ),
                    const SizedBox(height: 16),
                    FeaturesSection(features: data.features),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("加载失败: $e")),
      ),
    );
  }

  Widget _buildOverviewItem(
    BuildContext context, IconData icon, String label, String content) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(200),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
