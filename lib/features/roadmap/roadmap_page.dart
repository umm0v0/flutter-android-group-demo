import 'package:flutter/material.dart';
import 'package:group_flutter_pages_demo/data/team_data.dart';
import 'package:group_flutter_pages_demo/shared/widgets/responsive_wrapper.dart';
import 'package:group_flutter_pages_demo/core/theme/app_colors.dart';

class RoadmapPage extends StatelessWidget {
  const RoadmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = TeamData.releaseNotes;

    return Scaffold(
      appBar: AppBar(title: const Text('项目路线图')),
      body: SingleChildScrollView(
        child: ResponsiveWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                '迭代历程',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '从项目启动到当前版本的完整迭代记录',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(150),
                    ),
              ),
              const SizedBox(height: 32),
              for (var i = 0; i < notes.length; i++) ...[
                _RoadmapItem(
                  note: notes[i],
                  isLast: i == notes.length - 1,
                  index: notes.length - i,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RoadmapItem extends StatelessWidget {
  const _RoadmapItem({
    required this.note,
    required this.isLast,
    required this.index,
  });

  final dynamic note;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stages = {
      'v1.0.0': _Stage(
        icon: Icons.flag_outlined,
        color: const Color(0xFF10B981),
        label: '项目启动',
      ),
      'v1.1.0': _Stage(
        icon: Icons.cloud_outlined,
        color: const Color(0xFF06B6D4),
        label: '部署上线',
      ),
      'v2.0.0': _Stage(
        icon: Icons.rocket_launch_outlined,
        color: AppColors.primary,
        label: '架构升级',
      ),
    };

    final stage = stages[note.version] ??
        _Stage(
          icon: Icons.circle,
          color: Colors.grey,
          label: '迭代',
        );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stage.color.withAlpha(30),
                  border: Border.all(color: stage.color, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: stage.color.withAlpha(50),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(stage.icon, color: stage.color, size: 24),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '$index',
                            style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.w900,
                              color: stage.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          stage.color.withAlpha(100),
                          stages.values.last.color.withAlpha(30),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: stage.color.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              note.version,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: stage.color,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: stage.color.withAlpha(15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              stage.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: stage.color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            note.date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withAlpha(120),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        note.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stage {
  final IconData icon;
  final Color color;
  final String label;
  const _Stage({
    required this.icon,
    required this.color,
    required this.label,
  });
}
