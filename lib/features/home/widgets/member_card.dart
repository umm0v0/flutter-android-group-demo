import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_flutter_pages_demo/models/team_member.dart';
import 'package:group_flutter_pages_demo/shared/widgets/skill_chip.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({required this.member, super.key});

  final TeamMember member;

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAvatar = widget.member.avatarUrl.isNotEmpty;
    final initials = widget.member.name.isNotEmpty
        ? widget.member.name.characters.first
        : '?';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.pushNamed(
          'memberDetail',
          pathParameters: {'id': widget.member.id},
        ),
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: _isHovered ? const Offset(0, -0.02) : Offset.zero,
          child: Card(
            elevation: _isHovered ? 8 : 1,
            shadowColor: theme.colorScheme.primary.withAlpha(
              _isHovered ? 60 : 15,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: theme.colorScheme.primary
                                    .withAlpha(80),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: hasAvatar
                          ? ClipOval(
                              child: Image.network(
                                widget.member.avatarUrl,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) =>
                                    _InitialsText(initials),
                              ),
                            )
                          : _InitialsText(initials),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.member.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.member.role,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (widget.member.skills.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: widget.member.skills
                          .take(4)
                          .map((s) => SkillChip(s))
                          .toList(),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    widget.member.task,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(180),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InitialsText extends StatelessWidget {
  const _InitialsText(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
