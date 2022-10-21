import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todos = [];

  final _localBox = Hive.box('localBox');

  void createInitialData() {
    todos = [
      ['Create Flutter CRUD', false],
      ['Create Website with Bootstrap', false],
    ];
  }

  void loadData() {
    todos = _localBox.get('todos');
  }

  void updateDatabase() {
    _localBox.put('todos', todos);
  }
}
