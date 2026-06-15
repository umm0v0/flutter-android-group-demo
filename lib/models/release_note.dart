class ReleaseNote {
  final String version;
  final String date;
  final String title;
  final String description;
  final ReleaseNoteType type;

  const ReleaseNote({
    required this.version,
    required this.date,
    required this.title,
    required this.description,
    this.type = ReleaseNoteType.release,
  });
}

enum ReleaseNoteType { feature, bugfix, release, deploy }
