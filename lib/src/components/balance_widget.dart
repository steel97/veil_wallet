import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';

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
                    const SizedBox(height: 45),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextButton.icon(
                            icon: const Icon(
                              Icons.copy_rounded,
                              size: 18,
                            ),
                            onPressed: () {},
                            label: ExtendedText(
                              context.watch<WalletState>().selectedAddress,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              overflowWidget: const TextOverflowWidget(
                                position: TextOverflowPosition.middle,
                                align: TextOverflowAlign.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '\u2026',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              style: const TextStyle(fontSize: 12),
                            ),
                          )),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.expand_more_outlined,
                                color: Theme.of(context).primaryColor),
                            onSelected: (value) async {
                              await WalletHelper.setSelectedAddress(
                                  value, context);
                            },
                            itemBuilder: (context) {
                              List<PopupMenuItem<String>> addresses =
                                  List.empty(growable: true);
                              context
                                  .read<WalletState>()
                                  .ownedAddresses
                                  .forEach((element) {
                                addresses.add(PopupMenuItem<String>(
                                    value: element.address,
                                    child: ExtendedText(element.address,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        overflowWidget:
                                            const TextOverflowWidget(
                                          position: TextOverflowPosition.middle,
                                          align: TextOverflowAlign.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[Text('\u2026')],
                                          ),
                                        ))));
                              });
                              return addresses;
                            },
                          )
                        ])
                  ])),
        ));
  }
}
