import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:flutter_bootcamp/uris.dart';
import 'package:http/http.dart' as http;

class Example6PageForm extends StatefulWidget {
  @override
  _Example6PageFormState createState() => _Example6PageFormState();
}

class _Example6PageFormState extends State<Example6PageForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = "";
  String _calories = "";

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

  Widget _inputCalories() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onSaved: (val) => _calories = val ?? "",
        style: TextStyle(fontWeight: FontWeight.bold),
        validator: (val) =>
            (val != null && val.isNotEmpty && double.tryParse(val) != null)
                ? null
                : "Issue in Calories",
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            labelText: "Calories",
            hintText: "Enter a Calories"),
      ),
    );
  }

  Widget _formPage() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 5),
            _inputName(),
            SizedBox(height: 5),
            _inputCalories()
          ],
        ));
  }

  Widget _fabSaveData() {
    return FloatingActionButton.extended(
        onPressed: _saveData, label: Text("Save Data"), icon: Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _formPage(),
      floatingActionButton: _fabSaveData(),
    );
  }

  void _saveData() async {
    final FormState? _formState = _formKey.currentState;
    if (_formState != null && _formState.validate()) {
      _formState.save();

      try {
        Map<String, dynamic> _jsonFood = {
          "name": _name,
          "calories": double.tryParse(_calories)
        };

        http.Response _response = await http.post(Uri.parse(Uris().foodsApi),
            body: json.encode(_jsonFood),
            headers: {"Content-Type": "application/json"},
            encoding: Encoding.getByName("utf-8"));

        if(_response.statusCode == 201) {
          snackMessage(message: "Saved :D", context: context);
          Navigator.of(context).pop();
        } else{
          final errorServer = await json.decode(utf8.decode(_response.bodyBytes));
          snackMessage(message: "${errorServer.toString()}", context: context, isError: true);
        }
      } catch (error) {
        snackMessage(
            message: "${error.toString()}", context: context, isError: true);
      }
    } else {
      snackMessage(
          message: "Issue Inside the Form", context: context, isError: true);
    }
  }
}
