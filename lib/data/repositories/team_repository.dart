import 'package:group_flutter_pages_demo/models/team_member.dart';
import 'package:group_flutter_pages_demo/models/project_feature.dart';
import 'package:group_flutter_pages_demo/models/release_note.dart';

class TeamPageData {
  final String projectTitle;
  final String projectSlogan;
  final List<TeamMember> members;
  final List<ProjectFeature> features;
  final List<ReleaseNote> releaseNotes;

  const TeamPageData({
    required this.projectTitle,
    required this.projectSlogan,
    required this.members,
    required this.features,
    required this.releaseNotes,
  });
}

abstract class ITeamRepository {
  Future<TeamPageData> getTeamData();
  TeamMember? getMemberById(String id);
}
