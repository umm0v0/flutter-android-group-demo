class TeamMember {
  final String id;
  final String name;
  final String role;
  final String task;
  final String bio;
  final List<String> skills;
  final String avatarUrl;
  final String githubUrl;

  const TeamMember({
    required this.id,
    required this.name,
    required this.role,
    required this.task,
    this.bio = '',
    this.skills = const [],
    this.avatarUrl = '',
    this.githubUrl = '',
  });
}
