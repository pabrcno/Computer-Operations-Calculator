import 'package:flutter/material.dart';

class BSumConverter extends StatefulWidget {
  @override
  _BSumConverterState createState() => _BSumConverterState();
}

class _BSumConverterState extends State<BSumConverter> {
  String firstNumber = "";
  String secondNumber = "";
  String fBits = "";
  String sBits = "";
  String carrys = "";
  int intSum = 0;
  var bSum = "";
  int nBitsSum = 0;
  bool show = false;
  bool carry = false;
  bool zero = false;
  bool overflow = false;
  bool sign = false;
  String convert(String n) {
    n == "" ? n = "0" : n = n;

    int intN = int.parse(n);

    List nBitsLs = intN.toRadixString(2).toString().split("");
    nBitsLs.remove("-");
    while (nBitsLs.length < 8) {
      nBitsLs.insert(0, "0");
    }

    if (intN < 0) {
      for (int i = 0; i < nBitsLs.lastIndexOf("1"); i++) {
        nBitsLs[i] == "0" ? nBitsLs[i] = "1" : nBitsLs[i] = "0";
      }
    }

    return nBitsLs.join("");
  }

  String getCarrys(List n1, List n2) {
    List carry = [""];
    for (int i = 7; i >= 0; i--) {
      carry.insert(
          0,
          n1[i] == "0" && n2[i] == "0"
              ? "0"
              : n1[i] == "1" && n2[i] == "1"
                  ? "1"
                  : carry[0] == "1" && (n1[i] == "1" || n2[i] == "1")
                      ? "1"
                      : "0");
      carry.remove("");
    }
    return (carry.join(""));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Representacion de numeros enteros",
              style: TextStyle(fontSize: 22, color: Colors.white),
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
                  setState(() {
                    fBits = convert(firstNumber);
                    sBits = convert(secondNumber);
                    intSum = int.parse(firstNumber) + int.parse(secondNumber);
                    bSum = convert(intSum.toString());
                    show = true;
                    nBitsSum = bSum.length;
                    overflow = intSum > 127 || intSum < -128;
                    carrys = getCarrys(fBits.split(""), sBits.split(""));
                    carry =
                        carrys.split("")[1] == "1" || carrys.startsWith("1");
                    zero = intSum == 0;
                    sign = intSum < 0 && !overflow;
                  });
                },
                child: Text(
                  "Convertir y calcular la suma",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            show
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                            child: Table(
                          children: [
                            TableRow(children: [
                              Container(
                                  child: Text(
                                "V",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                              Container(
                                  child: Text(
                                "C",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                              Container(
                                  child: Text(
                                "Z",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                              Container(
                                  child: Text(
                                "S",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                            ]),
                            TableRow(children: [
                              Container(
                                  child: Text(
                                "${overflow ? 1 : 0}",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              )),
                              Container(
                                  child: Text(
                                "${carry ? 1 : 0}",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              )),
                              Container(
                                  child: Text(
                                "${zero ? 1 : 0}",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              )),
                              Container(
                                  child: Text(
                                "${sign ? 1 : 0}",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              )),
                            ])
                          ],
                        )),
                        SizedBox(height: 20),
                        Text(
                          "$carrys",
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$firstNumber",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Text(
                                "$fBits",
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
                                "$sBits",
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
                                "$bSum",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                      ],
                    ))
                : Container()
          ],
        ));
  }
}
