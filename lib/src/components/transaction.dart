import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    color: Colors.white,
                    //border: Border.all(width: 2)
                  ),
                  child: Icon(Icons.arrow_downward_rounded),
                ),
                SizedBox(width: 15),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Received",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "6371d2a6307c42fbf9e9d277c651049ce436e98d8ea536772309f913d67278c6",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                )),
                SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text("+ 0,99 veil",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 211, 84))),
                  Text(
                    "20:44",
                    style: TextStyle(fontSize: 13),
                  )
                ]),
              ]),
            )));
  }
}
