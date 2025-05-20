import 'package:equatable/equatable.dart';

class Task extends Equatable {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;
  DateTime? createdAt;
  Duration? deadline;
  DateTime? dueAt;

  Task({
    this.id,
    this.title,
    this.description,
    this.isCompleted = false,
    this.createdAt,
    this.deadline,
  }) : dueAt = (createdAt != null && deadline != null)
            ? createdAt.add(deadline)
            : null;

  /// Construtor fromJson
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    deadline = json['deadline'] != null ? Duration(seconds: json['deadline']) : null;
    dueAt = json['dueAt'] != null ? DateTime.parse(json['dueAt']) : null;
  }

  /// Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt?.toIso8601String(),
      'deadline': deadline?.inSeconds, // salva em segundos
      'dueAt': dueAt?.toIso8601String(),
    };
  }

  /// Método copyWith
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    Duration? deadline,
    DateTime? dueAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        createdAt,
        deadline,
        dueAt,
      ];
}
