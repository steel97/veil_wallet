import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/main_layout.dart';

class ImportSeed extends StatelessWidget {
  const ImportSeed({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter 24 words seed:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(24, (index) {
                        return Container(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                child: SizedBox(
                                    width: 24, child: Text("${index + 1}."))),
                            Expanded(
                                child: TextField(
                              textAlignVertical: TextAlignVertical(y: -0.4),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 0.0),
                                border: UnderlineInputBorder(),
                                hintText: '',
                              ),
                            ))
                          ],
                        ));
                      }),
                    ))),
            Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0.0),
                      border: UnderlineInputBorder(),
                      hintText: 'Encryption password',
                      label: Text("Wallet encryption password (if exists):")),
                )),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0.0),
                      border: UnderlineInputBorder(),
                      hintText: 'Encryption password (repeat)',
                      label: Text("Repeat wallet encryption password:")),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: Size.fromHeight(45)),
                onPressed: () {},
                icon: Icon(Icons.file_open_rounded),
                label: const Text('Load transactions'),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              minimumSize: Size.fromHeight(45)),
                          onPressed: () {},
                          child: const Text('Back'),
                        )),
                    SizedBox(width: 10),
                    Flexible(
                        flex: 1,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              minimumSize: Size.fromHeight(45)),
                          onPressed: () {},
                          child: const Text('Import'),
                        )),
                  ],
                ))
          ]),
    ));
  }
}
