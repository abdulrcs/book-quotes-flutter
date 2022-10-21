import 'package:flutter/material.dart';
import 'package:flutter_pemmob_crud/components/dialog_modal.dart';
import 'package:flutter_pemmob_crud/components/todo_card.dart';
import 'package:flutter_pemmob_crud/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _localBox = Hive.box('localBox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_localBox.get('todos') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.todos[index][1] = !db.todos[index][1];
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogModal(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todos.add([_controller.text, false]);
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('TODO'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.todos.length,
          itemBuilder: (context, index) {
            return TodoCard(
              taskName: db.todos[index][0],
              taskCompleted: db.todos[index][1],
              onChanged: (value) => checkBoxChanged(value!, index),
              onDelete: (context) => deleteTask(index),
            );
          },
        ));
  }
}
