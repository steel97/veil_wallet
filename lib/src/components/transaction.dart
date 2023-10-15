// ignore_for_file: empty_catches
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veil_wallet/src/core/constants.dart';
//import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/transactions.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';

class Transaction extends StatelessWidget {
  final int incKey;
  final TxType type;
  final String txid;
  final double amount;

  const Transaction(
      {super.key,
      required this.incKey,
      required this.type,
      required this.txid,
      required this.amount});

  Icon getTypeIcon(BuildContext context) {
    if (type == TxType.sent) {
      return Icon(
        size: 28,
        Icons.arrow_upward_rounded,
        color: Theme.of(context).colorScheme.primary,
      );
    } else if (type == TxType.received) {
      return Icon(
        size: 28,
        Icons.arrow_downward_rounded,
        color: Theme.of(context).colorScheme.primary,
      );
    }

    return Icon(
      size: 28,
      Icons.arrow_outward_rounded, //outwards
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Text getTypeText(BuildContext context) {
    return const Text(
      'RingCT',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    /*
    if (type == TxType.sent) {
      return Text(
        AppLocalizations.of(context)?.txTypeSent ?? stringNotFoundText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    } else if (type == TxType.received) {
      return Text(
        AppLocalizations.of(context)?.txTypeReceived ?? stringNotFoundText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    }

    return Text(
      AppLocalizations.of(context)?.txTypeUnknown ?? stringNotFoundText,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );*/
  }

  Text getAmountText(BuildContext context) {
    var amountTmp = amount.toStringAsFixed(2);
    if (type == TxType.sent) {
      return Text(
          context.watch<WalletState>().hideBalance
              ? ' $hiddenBalanceMask'
              : '-$amountTmp veil',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary));
    } else if (type == TxType.received) {
      return Text(
          context.watch<WalletState>().hideBalance
              ? ' $hiddenBalanceMask'
              : '+$amountTmp veil',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 211, 84)));
    }

    return Text(
        context.watch<WalletState>().hideBalance
            ? ' $hiddenBalanceMask'
            : ' $amountTmp veil',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context)
                .colorScheme
                .primary)); //color: Color.fromARGB(255, 148, 148, 148)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () async {
                  try {
                    var url = Uri.parse(BaseStaticState.txExplorerAddress
                        .replaceAll('{txid}', txid));
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  } catch (e) {}
                },
                child: Card(
                    elevation: 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        // icon
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(130),
                            color: Theme.of(context).colorScheme.background,
                            //border: Border.all(width: 2)
                          ),
                          child: getTypeIcon(context),
                        ),
                        // spacing between icon and data
                        const SizedBox(width: 15),
                        // all data
                        Expanded(
                            child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getTypeText(context),
                                  const SizedBox(height: 5),
                                  getAmountText(context)
                                ]),
                            const SizedBox(width: 1, height: 5),
                            Row(children: [
                              Expanded(
                                  child: ExtendedText(
                                txid,
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
                              )),
                            ])
                          ],
                        )),
                      ]),
                    )))));
  }
}
