import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/components/transaction.dart';
import 'package:veil_wallet/src/core/constants.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.transactionsLabel ??
                    stringNotFoundText,
                style: TextStyle(fontSize: 24),
              ),
              //Icon(Icons.refresh_rounded)
              /*IconButton.filled(
                  onPressed: () {}, icon: const Icon(Icons.refresh_rounded))*/
              /*FilledButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.refresh_rounded),
                  label: Text("Refresh"))*/
            ],
          ),
          SizedBox(height: 10),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction(),
          SizedBox(height: 5),
          Transaction()
        ]));
  }
}
