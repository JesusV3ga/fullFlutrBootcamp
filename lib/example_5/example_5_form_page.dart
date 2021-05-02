import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/database_helper.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:flutter_bootcamp/models_objects/task.dart';
import 'package:sqflite/sqflite.dart';

class Example5FormPage extends StatefulWidget {
  @override
  _Example5FormPageState createState() => _Example5FormPageState();
}

class _Example5FormPageState extends State<Example5FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = "";
  String _seconds = "";

  AppBar _appBar() {
    return AppBar(title: Text("Example 5"));
  }

  Widget _inputName() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (val) => _name = val ?? "",
        style: TextStyle(fontWeight: FontWeight.bold),
        validator: (val) =>
            (val != null && val.length > 5) ? null : "Issue in Name",
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            labelText: "Name",
            hintText: "Enter ur Name"),
      ),
    );
  }

  Widget _inputSeconds() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (val) => _seconds = val ?? "",
        style: TextStyle(fontWeight: FontWeight.bold),
        validator: (val) =>
            (val != null && val.isNotEmpty && int.tryParse(val) != null)
                ? null
                : "Issue in Seconds",
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            labelText: "Seconds",
            hintText: "Enter a Seconds"),
      ),
    );
  }

  Widget _formTask() {
    return Form(
        key: _formKey,
        child: Column(
          children: [SizedBox(height: 5),_inputName(), SizedBox(height: 5),_inputSeconds()],
        ));
  }

  Widget _fabSaveTask() {
    return FloatingActionButton.extended(
        onPressed: _saveData,
        label: Text("Save Task"),
        icon: Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _formTask(),
      floatingActionButton: _fabSaveTask(),
    );
  }

  void _saveData() async{
    final FormState? _formState = _formKey.currentState;
    if(_formState != null && _formState.validate()){
      _formState.save();

      try{
        Task _task = Task(name: _name, seconds: int.tryParse(_seconds));
        await _insertDataDB(_task);
        snackMessage(message: "Saved :D", context: context);
        Navigator.of(context).pop();
      }catch(error){
        snackMessage(message: "${error.toString()}", context: context, isError: true);
      }

    }else{
      snackMessage(message: "Issue Inside the Form", context: context, isError: true);
    }
  }

  Future<void> _insertDataDB(Task task) async{
    final Database? db = await DatabaseHelper.db.database;
    await db!.insert("task", task.toMapSQL());
  }
}
