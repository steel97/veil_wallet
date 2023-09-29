import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/welcome.dart';

class NewWalletSaveSeed extends StatelessWidget {
  const NewWalletSaveSeed({super.key});

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: "Save seed",
        back: () => {Navigator.of(context).push(_createBackRoute())},
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      width: double.infinity,
                      child: Text(
                        "New wallet seed:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
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
                              var txt = TextEditingController();
                              txt.text = "1. asdf";
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
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 0.0),
                                            border: UnderlineInputBorder(),
                                            hintText: '${index + 1}.',
                                          ),
                                          controller: txt))
                                ],
                              ));
                            }),
                          ))),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(45)),
                      onPressed: () {
                        Navigator.of(context).push(_createVerifySeedRoute());
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ])));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Welcome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}

Route _createVerifySeedRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NewWalletVerifySeed(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
