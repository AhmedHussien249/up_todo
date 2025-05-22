class TaskModel {
  final int? id;
  final String title;
  final String note;

  // final DateTime date;
  final String startTime;
  final String endTime;
  final int isCompleted;
  final int color;
  final String date;

  TaskModel({
    this.id,
    required this.date,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.color,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      date: json['date'],
      title: json['title'],
      note: json['note'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isCompleted: json['isCompleted'],
      color: json['color'],
    );
  }
}
