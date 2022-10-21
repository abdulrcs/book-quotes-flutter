import 'package:flutter/material.dart';
import 'package:flutter_pemmob_crud/components/dialog_modal.dart';
import 'package:flutter_pemmob_crud/components/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List todos = [
    ['Create Flutter CRUD', false],
    ['Create Website with Bootstrap', false],
  ];

  void checkBoxChanged(bool value, int index) {
    setState(() {
      todos[index][1] = !todos[index][1];
    });
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
  }

  void deleteTask(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void saveNewTask() {
    setState(() {
      todos.add([_controller.text, false]);
      Navigator.of(context).pop();
    });
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
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoCard(
              taskName: todos[index][0],
              taskCompleted: todos[index][1],
              onChanged: (value) => checkBoxChanged(value!, index),
              onDelete: (context) => deleteTask(index),
            );
          },
        ));
  }
}
