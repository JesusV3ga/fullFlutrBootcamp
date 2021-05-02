import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Excercise1Page extends StatefulWidget {
  @override
  _Excercise1PageState createState() => _Excercise1PageState();
}

class _Excercise1PageState extends State<Excercise1Page> {

  int _number = 0;

  AppBar _appBar() {
    return AppBar(title: Text("Example 2"));
  }

  Color _oddEvenNumbers(){ return _number % 2 == 0 ? Colors.red : Colors.blue;}

  Widget _body(){
    return Container(
        child: Center(
          child: Text(
            "Number: $_number",
            style: TextStyle(fontSize: 30, color: _oddEvenNumbers()),
          ),
        )
    );
  }

  Widget _fabIncrement() {
    return FloatingActionButton.extended(onPressed: _incrementNumber, label: Text("Increment"), icon: Icon(Icons.exposure_plus_1));
  }

  Widget _fabDecrement() {
    return FloatingActionButton.extended(onPressed: _decrementNumber, label: Text("Decrement"), icon: Icon(Icons.exposure_minus_1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: Column(mainAxisSize: MainAxisSize.min,
        children: [
          _fabIncrement(),
          SizedBox(height: 15),
          _fabDecrement()
        ],),

    );
  }

  void _incrementNumber(){
    _number++;
    setState(() {
    });
  }

  void _decrementNumber(){
    _number--;
    setState(() {
    });
  }
}
