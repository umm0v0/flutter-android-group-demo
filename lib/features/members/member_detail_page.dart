import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_flutter_pages_demo/data/team_data.dart';
import 'package:group_flutter_pages_demo/shared/widgets/skill_chip.dart';
import 'package:group_flutter_pages_demo/shared/widgets/responsive_wrapper.dart';
import 'package:group_flutter_pages_demo/core/theme/app_colors.dart';

class MemberDetailPage extends ConsumerWidget {
  const MemberDetailPage({required this.memberId, super.key});

  final String memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = TeamData.members.cast().firstWhere(
          (m) => m.id == memberId,
          orElse: () => null,
        );

    if (member == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('成员详情')),
        body: const Center(child: Text('未找到该成员')),
      );
    }

    final theme = Theme.of(context);
    final initials = member.name.characters.first;

    return Scaffold(
      appBar: AppBar(title: Text(member.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.gradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(60),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                member.name,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  member.role,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _InfoSection(
                icon: Icons.school_outlined,
                title: '教育背景',
                child: Text(
                  '云南大学 2024级 计算机科学与技术',
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
              ),
              const SizedBox(height: 16),
              if (member.bio.isNotEmpty)
                _InfoSection(
                  icon: Icons.person_outline,
                  title: '个人简介',
                  child: Text(
                    member.bio,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ),
              const SizedBox(height: 16),
              if (member.skills.isNotEmpty)
                _InfoSection(
                  icon: Icons.code,
                  title: '技术栈',
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: member.skills.map((s) => SkillChip(s)).toList(),
                  ),
                ),
              const SizedBox(height: 16),
              _InfoSection(
                icon: Icons.assignment_outlined,
                title: '分工任务',
                child: Text(
                  member.task,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
              ),
              const SizedBox(height: 16),
              if (member.githubUrl.isNotEmpty)
                _InfoSection(
                  icon: Icons.code,
                  title: 'GitHub',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.githubUrl,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: member.githubUrl));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('GitHub 链接已复制: ${member.githubUrl}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text('复制 GitHub 链接'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.icon,
    required this.title,
    required this.child,
  });
  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
