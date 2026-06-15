import 'package:group_flutter_pages_demo/data/team_data.dart';
import 'package:group_flutter_pages_demo/data/repositories/team_repository.dart';
import 'package:group_flutter_pages_demo/models/team_member.dart';

class LocalTeamRepository implements ITeamRepository {
  @override
  Future<TeamPageData> getTeamData() async {
    // 模拟网络延迟，同时展示骨架屏加载效果
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return TeamPageData(
      projectTitle: TeamData.projectTitle,
      projectSlogan: TeamData.projectSlogan,
      members: TeamData.members,
      features: TeamData.features,
      releaseNotes: TeamData.releaseNotes,
    );
  }

  @override
  TeamMember? getMemberById(String id) {
    return TeamData.members.cast<TeamMember?>().firstWhere(
          (m) => m!.id == id,
          orElse: () => null,
        );
  }
}
