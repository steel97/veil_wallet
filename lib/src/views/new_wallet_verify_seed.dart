import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class NewWalletVerifySeed extends StatelessWidget {
  const NewWalletVerifySeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: "Verify seed",
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Verify 24 words seed:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        minimumSize: Size.fromHeight(45)),
                    onPressed: () {},
                    child: const Text('Create wallet'),
                  ),
                ),
              ]),
        ));
  }
}
