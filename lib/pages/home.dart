import 'package:flutter/material.dart';
import 'package:flutter_pemmob_crud/components/book_card.dart';
import 'package:flutter_pemmob_crud/components/dialog_modal.dart';
import 'package:flutter_pemmob_crud/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _localBox = Hive.box('localBox');
  QuotesDatabase db = QuotesDatabase();

  @override
  void initState() {
    if (_localBox.get('quotes') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.quotes[index][1] = !db.quotes[index][1];
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
      db.quotes.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.quotes.add([_controller.text, false]);
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Book Quotes',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.quotes.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Expanded(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/reading.png',
                          width: 300,
                        ),
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.brown,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                    BookCard(
                      quoteText: db.quotes[index][0],
                      author: db.quotes[index][1],
                      bookTitle: db.quotes[index][2],
                      chapterName: db.quotes[index][3],
                      imageUrl: db.quotes[index][4],
                    ),
                  ],
                ),
              );
            } else {
              return BookCard(
                quoteText: db.quotes[index][0],
                author: db.quotes[index][1],
                bookTitle: db.quotes[index][2],
                chapterName: db.quotes[index][3],
                imageUrl: db.quotes[index][4],
              );
            }
          },
        ));
  }
}
