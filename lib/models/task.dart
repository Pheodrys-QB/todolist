import 'package:mobx/mobx.dart';

class Task {
  int id;

  @observable
  String title;

  bool isScheduled;
  DateTime scheduleTime;

  Task(this.id, this.title, this.isScheduled, this.scheduleTime);
  void updateWith(Task newTask) {
    title = newTask.title;
    isScheduled = newTask.isScheduled;
    scheduleTime = newTask.scheduleTime;
  }
}
