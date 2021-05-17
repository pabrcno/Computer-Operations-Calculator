import 'package:baseconvert/baseconvert.dart';
import 'package:flutter/material.dart';

class IeeeConverter extends StatefulWidget {
  @override
  _IeeeConverterState createState() => _IeeeConverterState();
}

class _IeeeConverterState extends State<IeeeConverter> {
  String number = "";
  bool show = false;
  String ieee;
  BaseConverter bc = BaseConverter(inBase: 10, outBase: 2);
  String convertToIeee(String number) {
    List decimal = number.split("");
    String sign = double.parse(number) < 0 ? "1" : "0";
    bool recurrent = false;
    List binary = bc.convert(number);
    if (binary.contains("[")) recurrent = true;

    List period = recurrent
        ? binary.sublist(binary.indexOf("["), binary.indexOf("]") - 1)
        : null;
    binary.remove("-");
    binary.remove("[");
    binary.remove("]");

    int exponent = binary.indexOf(".") - binary.indexOf(1);
    exponent < 0 ? exponent += 1 : exponent -= 1;
    int movedExponent = exponent + 127;

    //first 8 bits
    String movedExponentB = movedExponent.toRadixString(2).toString();
    if (movedExponentB.length < 8)
      movedExponentB = ("0" * (8 - movedExponentB.length)) + movedExponentB;

    binary[binary.indexOf(1)] = ".";

    exponent > 0
        ? binary.removeWhere((element) => element == ".")
        : binary = binary.sublist(binary.lastIndexOf(".") + 1);

    String mantissa = binary.join("");

    String ieee = sign + movedExponentB + mantissa;

    while (ieee.length <= 32) {
      recurrent ? ieee += period.join("") : ieee += "0";
    }
    print("binary float");
    print(binary);
    print("ieee754");
    print(ieee);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: <Widget>[
            Text(
              "Decimal a IEEE 754",
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
                            number = text;
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
                    ieee = convertToIeee(number);
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
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Resultado:",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        )),
                        SizedBox(height: 20),
                        Text(
                          "$ieee",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                      ],
                    ))
                : Container()
          ],
        ));
  }
}
