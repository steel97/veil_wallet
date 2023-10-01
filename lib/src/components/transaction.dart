import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';

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
                    color: Theme.of(context).colorScheme.background,
                    //border: Border.all(width: 2)
                  ),
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.txTypeReceived ??
                          stringNotFoundText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //SizedBox(height: 5),
                    /*Text(
                      "6371d2a6307c42fbf9e9d277c651049ce436e98d8ea536772309f913d67278c6",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13),
                    )*/
                    ExtendedText(
                      "6371d2a6307c42fbf9e9d277c651049ce436e98d8ea536772309f913d67278c6",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      overflowWidget: TextOverflowWidget(
                        position: TextOverflowPosition.middle,
                        align: TextOverflowAlign.center,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text(
                                '\u2026',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )),
                SizedBox(width: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text("+ 0,99 veil",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 211, 84))),
                  //SizedBox(height: 5),
                  Text(
                    "20:44",
                    style: TextStyle(fontSize: 12),
                  )
                ]),
              ]),
            )));
  }
}
