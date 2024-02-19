// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStore, Store {
  Computed<List<Task>>? _$upcomingListComputed;

  @override
  List<Task> get upcomingList =>
      (_$upcomingListComputed ??= Computed<List<Task>>(() => super.upcomingList,
              name: '_TaskStore.upcomingList'))
          .value;
  Computed<List<Task>>? _$todayListComputed;

  @override
  List<Task> get todayList =>
      (_$todayListComputed ??= Computed<List<Task>>(() => super.todayList,
              name: '_TaskStore.todayList'))
          .value;

  late final _$countAtom = Atom(name: '_TaskStore.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$_TaskStoreActionController =
      ActionController(name: '_TaskStore', context: context);

  @override
  void add(Task newTask) {
    final _$actionInfo =
        _$_TaskStoreActionController.startAction(name: '_TaskStore.add');
    try {
      return super.add(newTask);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(int id, Task newTask) {
    final _$actionInfo =
        _$_TaskStoreActionController.startAction(name: '_TaskStore.update');
    try {
      return super.update(id, newTask);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(int id) {
    final _$actionInfo =
        _$_TaskStoreActionController.startAction(name: '_TaskStore.remove');
    try {
      return super.remove(id);
    } finally {
      _$_TaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count},
upcomingList: ${upcomingList},
todayList: ${todayList}
    ''';
  }
}
