import 'package:flutter/material.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      width: 70 * 1.5,
                                      height: 28 * 1.5,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  './assets/images/logo_full_light.png'),
                                              fit: BoxFit.fitWidth)))),
                              Flexible(
                                  flex: 1,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "99,45 \$",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "999,99 veil",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        )
                                      ]))
                            ])),
                    SizedBox(height: 35),
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
                            label: Text(
                              "sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12),
                            ),
                          )),
                          Theme(
                              data: Theme.of(context).copyWith(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                underline: null,
                                focusColor: Colors.transparent,
                                icon: Icon(Icons.expand_more_outlined,
                                    color: Theme.of(context).primaryColor),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColor),
                                value: "primary",
                                items: <DropdownMenuItem<String>>[
                                  DropdownMenuItem(
                                    child: new Text('primary'),
                                    value: 'primary',
                                  ),
                                  DropdownMenuItem(
                                      child: new Text('two'), value: 'two'),
                                ],
                                onChanged: (String? value) {
                                  //setState(() => _value = value);
                                },
                              )))
                        ]))
                  ])),
        ));
  }
}
