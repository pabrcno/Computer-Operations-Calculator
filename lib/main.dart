import 'package:cac/components/base_change.dart';
import 'package:cac/components/bcd_aiken.dart';
import 'package:cac/components/bcd_sum_converter.dart';
import 'package:cac/components/decimal_to_ieee754.dart';

import 'package:flutter/material.dart';

import 'components/binary_sum_converter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora ADC',
      home: MyHomePage(title: 'Calculadora ADC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String firstNumber;
  String secondNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculadora ADC",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[850],
        ),
        body: Container(
            color: Colors.grey[850],
            child: SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  BaseChanger(),
                  BSumConverter(),
                  BCDSumConverter(),
                  BCDAikenSumConverter(),
                  IeeeConverter(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "0.0.2",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Made with ❤️ by Paulo",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              )),
            )));
  }
}
