enum TaskStatus {
  pending,
  inProgress,
  completed;

  String get label {
    switch (this) {
      case TaskStatus.pending:
        return "待完成";
      case TaskStatus.inProgress:
        return "进行中";
      case TaskStatus.completed:
        return "已完成";
    }
  }

  String get iconName {
    switch (this) {
      case TaskStatus.pending:
        return "pending";
      case TaskStatus.inProgress:
        return "in_progress";
      case TaskStatus.completed:
        return "completed";
    }
  }
}

class ExperimentTask {
  final String title;
  final String description;
  final String assignee;
  final TaskStatus status;

  const ExperimentTask({
    required this.title,
    required this.description,
    required this.assignee,
    required this.status,
  });
}
