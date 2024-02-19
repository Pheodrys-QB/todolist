import 'package:flutter/material.dart';
import 'package:test_drive/models/task.dart';
import 'package:test_drive/screens/edit_task_page.dart';
import 'package:test_drive/service_locator.dart';
import 'package:test_drive/stores/task_store.dart';

var store = serviceLocator.get<TaskStore>();

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  String searchText = '';
  List<Task> resultList = store.todoList;

  void setFilter(String value) {
    if (value.isEmpty) {
      resultList = store.todoList;
    } else {
      resultList =
          store.todoList.where((e) => e.title.contains(value)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Search task"),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 10),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: <Widget>[
                TextField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                        setFilter(value);
                      });
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Search")),
                Expanded(
                    child: ListView.builder(
                        itemCount: resultList.length,
                        itemBuilder: (context, index) {
                          final task = resultList[index];
                          return Dismissible(
                              key: Key(task.id.toString()),
                              direction: DismissDirection.endToStart,
                              //direction: DismissDirection.endToStart,
                              onDismissed: (dir) {
                                store.remove(task.id);
                              },
                              child: Card(
                                  child: ListTile(
                                title: Text(task.title),
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTaskPage(task: task)))
                                      .then((value) => setState(() {
                                            setFilter(searchText);
                                          }));
                                },
                              )));
                        }))
              ],
            ),
          ),
        ));
  }
}
