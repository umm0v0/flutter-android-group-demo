import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_flutter_pages_demo/core/constants/app_constants.dart';
import 'package:group_flutter_pages_demo/shared/widgets/responsive_wrapper.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withAlpha(8)
            : Colors.black.withAlpha(10),
        border: Border(
          top: BorderSide(
            color: theme.dividerColor.withAlpha(50),
          ),
        ),
      ),
      child: ResponsiveWrapper(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              AppConstants.appName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '由《Flutter实战·第二版》课程驱动',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              children: [
                _FooterLink(
                  icon: Icons.code,
                  label: 'GitHub',
                  onTap: () {},
                ),
                _FooterLink(
                  icon: Icons.school,
                  label: '20241060163 · 温道庚',
                  onTap: null,
                ),
                _FooterLink(
                  icon: Icons.route,
                  label: '项目路线图',
                  onTap: () => context.pushNamed('roadmap'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '© ${DateTime.now().year} ${AppConstants.githubOrg} · Built with Flutter Web',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: onTap != null
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
