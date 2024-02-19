import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_drive/models/task.dart';
import 'package:test_drive/screens/edit_task_page.dart';
import 'package:test_drive/service_locator.dart';
import 'package:test_drive/services/notification_service.dart';
import 'package:test_drive/stores/task_store.dart';

var service = serviceLocator.get<TaskStore>();

class TodayTask extends StatefulWidget {
  const TodayTask({super.key});
  @override
  State<TodayTask> createState() => _TodayTask();
}

class _TodayTask extends State<TodayTask> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => Center(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ListView.builder(
                      itemCount: service.todayList.length,
                      itemBuilder: (context, index) {
                        final Task task = service.todayList[index];
                        return Dismissible(
                            key: Key(task.id.toString()),
                            direction: DismissDirection.endToStart,
                            //direction: DismissDirection.endToStart,
                            onDismissed: (dir) {
                              serviceLocator
                                  .get<NotificationService>()
                                  ?.cancelNotification(task.id);
                              service.remove(task.id);
                            },
                            child: Card(
                                child: ListTile(
                              title: Text(task.title),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditTaskPage(task: task)));
                              },
                            )));
                      })),
            ));
  }
}
