import 'package:baseconvert/baseconvert.dart';
import 'package:flutter/material.dart';

class BaseChanger extends StatefulWidget {
  @override
  _BaseChangerState createState() => _BaseChangerState();
}

class _BaseChangerState extends State<BaseChanger> {
  String number = "";
  String base = "";
  String outputBase = "";
  bool show = false;
  BaseConverter baseConverter;
  List result;

  List resultAdapter(List result) {
    List fixed = [];

    result.forEach((element) {
      element == 10
          ? element = "A"
          : element == 11
              ? element = "B"
              : element == 12
                  ? element = "C"
                  : element == 13
                      ? element = "D"
                      : element == 14
                          ? element = "E"
                          : element == 15
                              ? element = "F"
                              : element == 16
                                  ? element = "G"
                                  : element = element;
      fixed.add(element);
    });
    if (int.parse(this.outputBase) > 10)
      return fixed;
    else
      return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Cambios de Base",
              style: TextStyle(fontSize: 27, color: Colors.white),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Numero",
                                filled: true,
                                fillColor: Colors.white),

                            onChanged: (text) {
                              setState(() {
                                number = text;
                              });
                            }, // Only numbers can be entered
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Base",
                                filled: true,
                                fillColor: Colors.white),
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              setState(() {
                                base = text;
                              });
                            }, // Only numbers can be entered
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Base de Salida",
                            filled: true,
                            fillColor: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            outputBase = text;
                          });
                        }, // Only numbers can be entered
                      ),
                    ),
                  ]),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    baseConverter = BaseConverter(
                        inBase: int.parse(base),
                        outBase: int.parse(outputBase));
                    result = resultAdapter(baseConverter.convert(number));
                    show = true;
                  });
                },
                child: Text(
                  "Convertir",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            show
                ? Container(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Resultado:",
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                      Text(
                        "${result.join("")}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ))
                : Container()
          ],
        ));
  }
}
