import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:test_drive/models/task.dart';
part 'task_store.g.dart';

// ignore: library_private_types_in_public_api
class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  int count = 0;

  ObservableList<Task> todoList = ObservableList<Task>();
  // ObservableList<Task> todayList = ObservableList<Task>();
  // ObservableList<Task> upcomingList = ObservableList<Task>();

  @computed
  List<Task> get upcomingList => todoList.where((e) {
        if (!e.isScheduled) return false;
        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        return e.scheduleTime.difference(today).inDays >= 1;
      }).toList();

  @computed
  List<Task> get todayList => todoList
      .where((e) =>
          e.isScheduled && DateUtils.isSameDay(e.scheduleTime, DateTime.now()))
      .toList();

  // void updateUpcoming() {
  //   upcomingList.clear();
  //   for (Task e in todoList) {
  //     if (!e.isScheduled) continue;
  //     DateTime now = DateTime.now();
  //     DateTime today = DateTime(now.year, now.month, now.day);
  //     if (e.scheduleTime.difference(today).inDays >= 1) upcomingList.add(e);
  //   }
  // }

  // void updateToday() {
  //   todayList.clear();
  //   for (Task e in todoList) {
  //     if (!e.isScheduled) continue;
  //     if (DateUtils.isSameDay(e.scheduleTime, DateTime.now())) todayList.add(e);
  //   }
  // }

  @action
  void add(Task newTask) {
    todoList.add(newTask);
    count++;
    // updateToday();
    // updateUpcoming();
  }

  @action
  void update(int id, Task newTask) {
    final idx = todoList.indexWhere((e) => e.id == id);

    todoList[idx] = newTask;

    // updateToday();
    // updateUpcoming();
  }

  @action
  void remove(int id) {
    final idx = todoList.indexWhere((e) => e.id == id);
    todoList.removeAt(idx);
    // updateToday();
    // updateUpcoming();
  }
}
