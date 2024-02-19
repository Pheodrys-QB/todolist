import 'package:flutter/material.dart';
import 'package:test_drive/screens/add_task_page.dart';
import 'package:test_drive/screens/search_page.dart';
import 'package:test_drive/widgets/all_tasks.dart';
import 'package:test_drive/widgets/today_tasks.dart';
import 'package:test_drive/widgets/upcoming_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final bool tick = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: const TabBar(tabs: <Widget>[
              Tab(text: 'All'),
              Tab(text: 'Today'),
              Tab(text: 'Upcoming')
            ]),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search),
                  tooltip: 'Search task',
                ),
              )
            ],
          ),
          body: const TabBarView(
              children: <Widget>[AllTask(), TodayTask(), UpcomingTask()]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // serviceLocator
              //     .get<NotificationService>()
              //     ?.showNotification(id: 0, title: 'test', body: 'on the way');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTaskPage()));
            },
            tooltip: 'Add task',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
