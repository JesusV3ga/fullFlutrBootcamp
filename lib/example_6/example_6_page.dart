import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/example_6/example_6_form_page.dart';
import 'package:flutter_bootcamp/methods/public.dart';
import 'package:flutter_bootcamp/uris.dart';
import 'package:http/http.dart' as http;

class Example6Page extends StatefulWidget {
  @override
  _Example6PageState createState() => _Example6PageState();
}

class _Example6PageState extends State<Example6Page> {
  List<dynamic>? _list;

  AppBar _appBar() {
    return AppBar(title: Text("Example 6"));
  }

  Widget _body() {
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_list!.isEmpty)
      return Center(
        child: Text("Not Data"),
      );
    return ListView(
        children: _list!.map((food) => Text("${food.toString()}")).toList());
  }

  Widget _fabGoToForm() {
    return FloatingActionButton.extended(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Example6PageForm()))
            .whenComplete(() => _loadDataFromServer()),
        label: Text("Add Task"),
        icon: Icon(Icons.add));
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadDataFromServer();
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

  void _loadDataFromServer() async {
    try {
      http.Response _response = await http.get(Uri.parse(Uris().foodsApi),
          headers: {
            "Content-Type": "application/json"
          }).timeout(Duration(seconds: 20));
      if (_response.statusCode == 200) {
        _list = await json.decode(utf8.decode(_response.bodyBytes));
        setState(() {});
      }
    } catch (error) {
      snackMessage(
          message: "${error.toString()}", context: context, isError: true);
    }
  }
}
