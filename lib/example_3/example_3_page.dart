import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//flutter clean
//flutter pub get
//flutter pub update

class Example3Page extends StatefulWidget {
  @override
  _Example3PageState createState() => _Example3PageState();
}

class _Example3PageState extends State<Example3Page> {
  List<int> _list = [];

  @override
  AppBar _appBar() {
    return AppBar(title: Text("Example 2"));
  }

  Widget _body() {
    if (_list.isEmpty)
      return Container(
          child: Center(
        child: Text(
          "No Data",
          style: TextStyle(fontSize: 30, color: Colors.grey),
        ),
      ));
    return ListView(
        children: _list.map((_number) => _customItem(numberItem: _number)).toList());
  }

  Widget _customItem({required final int numberItem}){
    return ListTile(title: Text("$numberItem"), onTap: () => _onTapItem(removeNumber: numberItem));
  }

  Widget _fabAddNumber() {
    return FloatingActionButton.extended(
        onPressed: _addSomeNumber,
        label: Text("Add Number"),
        icon: Icon(Icons.add));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: _fabAddNumber());
  }

  void _addSomeNumber() {
    _list.add(Random().nextInt(99999));
    setState(() {});
  }

  void _onTapItem({required final removeNumber}){
    _list.remove(removeNumber);
    setState(() {});
  }
}
