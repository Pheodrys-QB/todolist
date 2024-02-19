import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/models/task.dart';
import 'package:test_drive/service_locator.dart';
import 'package:test_drive/services/notification_service.dart';
import 'package:test_drive/stores/task_store.dart';

var store = serviceLocator.get<TaskStore>();

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPage();
}

class _AddTaskPage extends State<AddTaskPage> {
  late TextEditingController textController;

  bool isScheduled = false;
  DateTime scheduleTime = DateTime.now();

  late Future<DateTime?> selectedDate;
  String date =
      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}";

  late Future<TimeOfDay?> selectedTime;
  String time = "${DateTime.now().hour} : ${DateTime.now().minute}";

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void createTask() {
    Task task =
        Task(store.count, textController.text, isScheduled, scheduleTime);
    if (isScheduled) {
      TimeOfDay t = TimeOfDay(
          hour: int.parse(time.split(":")[0]),
          minute: int.parse(time.split(":")[1]));
      DateTime d = DateTime(
        int.parse(date.split("-")[0]),
        int.parse(date.split("-")[1]),
        int.parse(date.split("-")[2]),
      );
      task.scheduleTime = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      //Setup notification

      serviceLocator.get<NotificationService>()?.scheduleNotification(
          id: task.id, title: task.title, body: '${task.title}in 10 minutes', schedultTime: task.scheduleTime);
    }
    store.add(task);
  }

  List<Widget> buildChildren() {
    var builder = [
      TextField(
          controller: textController,
          autofocus: true,
          onChanged: (value) {
            setState(() {});
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Task title',
          )),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
                value: isScheduled,
                onChanged: (bool? value) {
                  setState(() {
                    isScheduled = !isScheduled;
                  });
                }),
            const Text("Enable schedule notifiaction")
          ],
        ),
      )
    ];
    if (isScheduled) {
      builder.add(
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      showDialogDatePicker(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        padding: const EdgeInsets.all(15)),
                    child: Text(
                      date,
                      style: const TextStyle(fontSize: 20),
                    )),
                const Text("  |   "),
                TextButton(
                  onPressed: () {
                    showDialogTimePicker(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      padding: const EdgeInsets.all(15)),
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            )),
      );
    }
    return builder;
  }

  void showDialogDatePicker(BuildContext context) {
    selectedDate = showDatePicker(
      context: context,
      helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if (value == null) return;
        date = "${value.year} - ${value.month} - ${value.day}";
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDialogTimePicker(BuildContext context) {
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedTime.then((value) {
      setState(() {
        if (value == null) return;
        time = "${value.hour} : ${value.minute}";
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Add task"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: TextButton(
                onPressed: textController.text.isEmpty
                    ? null
                    : () {
                        createTask();
                        Navigator.pop(context);
                      },
                child: const Text('Add'),
              ),
            )
          ],
        ),
        body: Center(
            child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: .9,
          child: Column(
            children: buildChildren(),
          ),
        )));
  }
}
