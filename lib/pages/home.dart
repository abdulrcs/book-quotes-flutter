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

  final _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void editQuote(int index) {
    showDialog(
      context: context,
      builder: (context) {
        _controllers[0].text = db.quotes[index][0];
        _controllers[1].text = db.quotes[index][1];
        _controllers[2].text = db.quotes[index][2];
        _controllers[3].text = db.quotes[index][3];
        _controllers[4].text = db.quotes[index][4];
        return DialogModal(
          controllers: _controllers,
          onSave: () {
            db.quotes[index][0] = _controllers[0].text;
            db.quotes[index][1] = _controllers[1].text;
            db.quotes[index][2] = _controllers[2].text;
            db.quotes[index][3] = _controllers[3].text;
            db.quotes[index][4] = _controllers[4].text;
            db.updateDatabase();
            Navigator.pop(context);
            setState(() {});
         },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void createNewTask() {
    _controllers[0].text = '';
    _controllers[1].text = '';
    _controllers[2].text = '';
    _controllers[3].text = '';
    _controllers[4].text = '';
    showDialog(
        context: context,
        builder: (context) {
          return DialogModal(
            controllers: _controllers,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDatabase();
  }

  void deleteQuote(int index) {
    setState(() {
      db.quotes.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.quotes.add([
        _controllers[0].text,
        _controllers[1].text,
        _controllers[2].text,
        _controllers[3].text,
        _controllers[4].text,
      ]);
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
          padding: EdgeInsets.only(bottom: 100),
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
                        SizedBox(height: 24),
                      ],
                    ),
                    BookCard(
                      quoteText: db.quotes[index][0],
                      author: db.quotes[index][1],
                      bookTitle: db.quotes[index][2],
                      chapterName: db.quotes[index][3],
                      imageUrl: db.quotes[index][4],
                      onDelete: (context) => deleteQuote(index),
                      onEdit: (context) => editQuote(index),
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
                onDelete: (context) => deleteQuote(index),
                onEdit: (context) => editQuote(index),
              );
            }
          },
        ));
  }
}
