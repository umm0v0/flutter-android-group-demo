import 'package:flutter/material.dart';
import 'package:group_flutter_pages_demo/models/team_member.dart';
import 'package:group_flutter_pages_demo/features/home/widgets/member_card.dart';
import 'package:group_flutter_pages_demo/shared/widgets/section_header.dart';
import 'package:group_flutter_pages_demo/shared/widgets/responsive_wrapper.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({required this.members, super.key});

  final List<TeamMember> members;

  @override
  Widget build(BuildContext context) {
    final count = crossAxisCount(context, mobile: 1, tablet: 2, desktop: 3);
    final memberCount = members.length;

    return ResponsiveWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.people_alt_outlined,
            title: '小组成员',
            subtitle: '本项目由以下成员协作完成',
          ),
          if (memberCount <= 3)
            Row(
              children: [
                for (final member in members)
                  Expanded(child: MemberCard(member: member)),
              ].addSpacing(const SizedBox(width: 16)),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.78,
              ),
              itemCount: members.length,
              itemBuilder: (context, index) => MemberCard(member: members[index]),
            ),
        ],
      ),
    );
  }
}

extension _Spacing on List<Widget> {
  List<Widget> addSpacing(Widget spacer) {
    if (length <= 1) return this;
    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(spacer);
    }
    return result;
  }
}
