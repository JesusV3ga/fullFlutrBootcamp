import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/database_helper.dart';
import 'package:flutter_bootcamp/example_5/example_5_form_page.dart';
import 'package:flutter_bootcamp/models_objects/task.dart';
import 'package:sqflite/sqflite.dart';

class Example5Page extends StatefulWidget {
  @override
  _Example5PageState createState() => _Example5PageState();
}

class _Example5PageState extends State<Example5Page> {
  List<Task>? listTasks;

  AppBar _appBar() {
    return AppBar(title: Text("Example 5"));
  }

  Widget _body() {
    if (listTasks == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTasks!.isEmpty)
      return Center(
        child: Text("Not Data"),
      );
    return ListView(
        children: listTasks!.map((task) => Text("${task.name}, Seconds: ${task.seconds}")).toList());
  }

  Widget _fabGoToForm() {
    return FloatingActionButton.extended(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Example5FormPage())).whenComplete(() => _readDataFromDB()),
        label: Text("Add Task"),
        icon: Icon(Icons.add));
  }
  
  @override
  void initState() {
    // TODO: implement initState
    _readDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _fabGoToForm(),
    );
  }

  void _readDataFromDB() async {
    final Database? db = await DatabaseHelper.db.database;
    List<dynamic>? results = await db!.query("task");
    if (results == null || results!.isEmpty) return null;
    listTasks = results.map((results) => Task.fromMAPSQL(results)).toList();
    setState(() {});
  }
}
