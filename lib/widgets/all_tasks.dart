import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_drive/screens/edit_task_page.dart';
import 'package:test_drive/service_locator.dart';
import 'package:test_drive/services/notification_service.dart';
import 'package:test_drive/stores/task_store.dart';

var service = serviceLocator.get<TaskStore>();

class AllTask extends StatefulWidget {
  const AllTask({super.key});
  @override
  State<AllTask> createState() => _AllTask();
}

class _AllTask extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) => Center(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ListView.builder(
                      itemCount: service.todoList.length,
                      itemBuilder: (context, index) {
                        final task = service.todoList[index];
                        return Observer(
                            builder: (context) => Dismissible(
                                key: Key(task.id.toString()),
                                direction: DismissDirection.endToStart,
                                //direction: DismissDirection.endToStart,
                                onDismissed: (dir) {
                                  if (task.isScheduled) {
                                    serviceLocator
                                        .get<NotificationService>()
                                        ?.cancelNotification(task.id);
                                  }
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
                                ))));
                      })),
            ));
  }
}
