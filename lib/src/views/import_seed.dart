import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class ImportSeed extends StatelessWidget {
  const ImportSeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: "Import seed",
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0.0),
                          border: UnderlineInputBorder(),
                          hintText: 'Wallet name',
                          label: Text("Wallet name:")),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: double.infinity,
                    child: Text(
                      "Enter 24 words seed:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          crossAxisSpacing: 5,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(24, (index) {
                            return Container(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                /*Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                    width: 24, child: Text("${index + 1}."))),*/
                                Expanded(
                                    child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 0.0),
                                    border: UnderlineInputBorder(),
                                    hintText: '${index + 1}.',
                                  ),
                                ))
                              ],
                            ));
                          }),
                        ))),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.file_open_rounded),
                    label: const Text('Advanced'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    icon: Icon(Icons.upload_rounded),
                    label: const Text('Import'),
                  ),
                ),
              ]),
        ));
  }
}
