import 'package:flutter/material.dart';
import 'package:group_flutter_pages_demo/models/release_note.dart';
import 'package:group_flutter_pages_demo/shared/widgets/section_header.dart';
import 'package:group_flutter_pages_demo/shared/widgets/responsive_wrapper.dart';

class ReleaseTimeline extends StatelessWidget {
  const ReleaseTimeline({required this.releaseNotes, super.key});

  final List<ReleaseNote> releaseNotes;

  @override
  Widget build(BuildContext context) {
    final size = screenSize(context);
    final isDesktop = size == ScreenSize.desktop;

    return ResponsiveWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.history,
            title: '发布说明',
            subtitle: '项目迭代与部署记录',
          ),
          _Timeline(
            notes: releaseNotes,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.notes, required this.isDesktop});

  final List<ReleaseNote> notes;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < notes.length; i++) ...[
          if (i > 0) const SizedBox(height: 0),
          if (isDesktop && i.isEven)
            _TimelineItemRight(note: notes[i])
          else
            _TimelineItemLeft(note: notes[i]),
        ],
      ],
    );
  }
}

class _TimelineItemLeft extends StatelessWidget {
  const _TimelineItemLeft({required this.note});

  final ReleaseNote note;

  @override
  Widget build(BuildContext context) {
    final typeConfig = _typeConfigs[note.type]!;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TimelineDot(icon: typeConfig.icon, color: typeConfig.color),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _NoteCard(note: note, typeConfig: typeConfig),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItemRight extends StatelessWidget {
  const _TimelineItemRight({required this.note});

  final ReleaseNote note;

  @override
  Widget build(BuildContext context) {
    final typeConfig = _typeConfigs[note.type]!;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _NoteCard(note: note, typeConfig: typeConfig),
            ),
          ),
          const SizedBox(width: 16),
          _TimelineDot(icon: typeConfig.icon, color: typeConfig.color),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(25),
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        Expanded(
          child: Container(
            width: 2,
            color: color.withAlpha(60),
          ),
        ),
      ],
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.typeConfig});

  final ReleaseNote note;
  final _TypeConfig typeConfig;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: typeConfig.color.withAlpha(25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    note.version,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: typeConfig.color,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  note.date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(120),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              note.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              note.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeConfig {
  final IconData icon;
  final Color color;
  const _TypeConfig({required this.icon, required this.color});
}

const _typeConfigs = {
  ReleaseNoteType.feature: _TypeConfig(
    icon: Icons.add_circle_outline,
    color: Color(0xFF10B981),
  ),
  ReleaseNoteType.bugfix: _TypeConfig(
    icon: Icons.bug_report_outlined,
    color: Color(0xFFF59E0B),
  ),
  ReleaseNoteType.release: _TypeConfig(
    icon: Icons.rocket_launch_outlined,
    color: Color(0xFF6366F1),
  ),
  ReleaseNoteType.deploy: _TypeConfig(
    icon: Icons.cloud_done_outlined,
    color: Color(0xFF06B6D4),
  ),
};
