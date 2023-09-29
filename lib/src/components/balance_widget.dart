import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Card(
          elevation: 0,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width: 70 * 1.5,
                                  height: 28 * 1.5,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              './assets/images/logo_full_light.png'),
                                          fit: BoxFit.fitWidth))),
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                    Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "3,059.25 \$",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: Text(
                                        "1456789.54207223 veil",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ]))
                            ])),
                    SizedBox(height: 45),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Expanded(
                              child: TextButton.icon(
                            icon: Icon(
                              Icons.copy_rounded,
                              size: 18,
                            ),
                            onPressed: () {},
                            label: ExtendedText(
                              "sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp",
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
                          )),
                          PopupMenuButton<int>(
                            icon: Icon(Icons.expand_more_outlined,
                                color: Theme.of(context).primaryColor),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                  value: 0,
                                  child: ExtendedText(
                                      "sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      overflowWidget: TextOverflowWidget(
                                        position: TextOverflowPosition.middle,
                                        align: TextOverflowAlign.center,
                                        child: Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('\u2026')
                                            ],
                                          ),
                                        ),
                                      ))),
                              PopupMenuItem<int>(
                                  value: 1,
                                  child: ExtendedText(
                                      "sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      overflowWidget: TextOverflowWidget(
                                        position: TextOverflowPosition.middle,
                                        align: TextOverflowAlign.center,
                                        child: Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('\u2026')
                                            ],
                                          ),
                                        ),
                                      ))),
                            ],
                          )
                        ]))
                  ])),
        ));
  }
}
