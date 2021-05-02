import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/example_1/example_1_page.dart';
import 'package:flutter_bootcamp/example_2/example_2_page.dart';
import 'package:flutter_bootcamp/example_3/example_3_page.dart';
import 'package:flutter_bootcamp/example_4/example_4_page.dart';
import 'package:flutter_bootcamp/example_5/example_5_page.dart';
import 'package:flutter_bootcamp/example_6/example_6_page.dart';
import 'package:flutter_bootcamp/homework/exercise_1.dart';


//HOMEWORK
//EJEMPLO 2 PERO PONER MÁS ESTILOS, QUE EL VALOR SEA TAL SEA PAR SEA ROJO Y SI ES IMPAR AZUL EL TESTO

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        //primaryColor: Colors.red[500]
        primaryColor: Colors.redAccent[700],
        accentColor: Colors.blue[500],
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Theme.of(context).primaryColor)

      ),
      home: Example6Page()
    );
  }
}