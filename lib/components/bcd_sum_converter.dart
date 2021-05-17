import 'package:flutter/material.dart';

class BCDSumConverter extends StatefulWidget {
  @override
  _BCDSumConverterState createState() => _BCDSumConverterState();
}

class _BCDSumConverterState extends State<BCDSumConverter> {
  String firstNumber = "";
  String secondNumber = "";
  String fBcd;
  String sBcd;
  int intSum;
  String bcdSum;
  bool show = false;

  String inputToBcd(String i) {
    if (i == "") return "";
    i = i.replaceAll(RegExp(r'-'), "");
    List digits = i.characters.map((digit) {
      String binaryDigit = int.parse(digit).toRadixString(2);
      List bcd = binaryDigit.split("");
      while (bcd.length != 4) {
        bcd.insert(0, "0");
      }
      return bcd.join("");
    }).toList();
    return digits.join(" ");
  }

  void sumBcd(String fn, String sn) {
    int intFn = int.parse(fn);
    int intSn = int.parse(sn);
    setState(() {
      intSum = intFn + intSn;
      bcdSum = intSum < 0
          ? "- " + inputToBcd((intFn + intSn).toString())
          : inputToBcd((intFn + intSn).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: <Widget>[
            Text(
              "BCD",
              style: TextStyle(fontSize: 27, color: Colors.white),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Numero",
                            filled: true,
                            fillColor: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            firstNumber = text;
                          });
                        }, // Only numbers can be entered
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Numero",
                            filled: true,
                            fillColor: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          setState(() {
                            secondNumber = text;
                          });
                        }, // Only numbers can be entered
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  sumBcd(firstNumber, secondNumber);
                  setState(() {
                    fBcd = inputToBcd(firstNumber);
                    sBcd = inputToBcd(secondNumber);
                    show = true;
                  });
                },
                child: Text(
                  "Convertir y calcular la suma",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            show
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$firstNumber",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Text(
                                "$fBcd",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$secondNumber",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Text(
                                "$sBcd",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            color: Colors.blue,
                            thickness: 2,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$intSum",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Text(
                                "$bcdSum",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                        SizedBox(height: 10),
                      ],
                    ))
                : Container()
          ],
        ));
  }
}
