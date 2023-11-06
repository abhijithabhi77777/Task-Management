class SampleTask {
  final String date;
  final String project;
  final String assignee;
  final String? task;
  final String? comments;
  final int originalEst;
  final int completedHr;
  final String status;
  final int billableHr;
  final String billable;

  // ... other fields ...

  SampleTask({
    required this.date,
    required this.project,
    required this.assignee,
    this.task,
    this.comments,
    required this.originalEst,
    required this.completedHr,
    required this.status,
    required this.billableHr,
    required this.billable,
  });
}

List<SampleTask> sampleTasks = [
  SampleTask(
      date: '2023-10-25',
      project: 'Project A',
      assignee: 'User 1',
      originalEst: 8,
      completedHr: 10,
      status: 'jsfadfsdlhflj',
      billable: 'yes',
      billableHr: 10),
  SampleTask(
      date: '2023-10-26',
      project: 'Project B',
      assignee: 'User 2',
      originalEst: 8,
      completedHr: 10,
      status: 'jsfadfsdlhflj',
      billable: 'yes',
      billableHr: 10),
  // Add more sample data...
];
