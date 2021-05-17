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

    if (intN < 0) {
      for (int i = 0; i < nBitsLs.lastIndexOf("1"); i++) {
        nBitsLs[i] == "0" ? nBitsLs[i] = "1" : nBitsLs[i] = "0";
      }
    }

    return nBitsLs.join("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Convertir a binario y Sumar",
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
                  setState(() {
                    fBits = convert(firstNumber);
                    sBits = convert(secondNumber);
                    intSum = int.parse(firstNumber) + int.parse(secondNumber);
                    bSum = convert(intSum.toString());
                    show = true;
                    nBitsSum = bSum.length;
                    overflow = nBitsSum > 7;
                    carry = fBits.startsWith("1") &&
                        sBits.startsWith("1") &&
                        nBitsSum == 7;
                    zero = intSum == 0;
                    sign = intSum < 0;
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Numero de bits de la suma: ",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                              Text(
                                "$nBitsSum",
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
