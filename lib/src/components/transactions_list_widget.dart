import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_wallet/src/components/transaction.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/transactions.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({super.key});

  Widget getAddressStatusWidget(BuildContext context, SyncState syncState) {
    if (syncState == SyncState.synced) {
      return Icon(Icons.check_rounded,
          color: Theme.of(context).colorScheme.primary,
          semanticLabel:
              AppLocalizations.of(context)?.syncStatusSyncedSemantics);
    }

    if (syncState == SyncState.failed) {
      return Icon(Icons.close_rounded,
          color: Theme.of(context).colorScheme.error,
          semanticLabel:
              AppLocalizations.of(context)?.syncStatusScanningFailedSemantics);
    }

    return SizedBox(
        height: 24.0,
        width: 24.0,
        child: Center(
            child: CircularProgressIndicator(
          semanticsLabel:
              AppLocalizations.of(context)?.syncStatusScanningSemantics,
        )));
  }

  @override
  Widget build(BuildContext context) {
    var incrementVal = context.watch<WalletState>().txRerender;
    var bigScreen = isBigScreen(context);

    List<Widget> txes = List.empty(growable: true);
    for (TransactionModel tx in TransactionCache.currentTxList.reversed) {
      var hasTxSent = TransactionCache.sentTransactions.contains(tx.txId);
      var hasTxUnk = TransactionCache.unknownTransactions.contains(tx.txId);

      var type = TxType.unknown;
      if (hasTxSent) {
        type = TxType.sent;
      } else if (hasTxUnk) {
        type = TxType.unknown;
      }

      txes.add(Transaction(
          incKey: incrementVal, type: type, txid: tx.txId, amount: tx.amount));
      txes.add(const SizedBox(height: 5));
    }

    if (TransactionCache.currentTxList.isEmpty) {
      txes.add(Text(
        AppLocalizations.of(context)?.transactionsListEmpty ??
            stringNotFoundText,
        textAlign: TextAlign.center,
      ));
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
            children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.transactionsLabel ??
                            stringNotFoundText,
                        style: const TextStyle(fontSize: 24),
                      ),
                      getAddressStatusWidget(
                          context, context.watch<WalletState>().syncState)
                      //Icon(Icons.refresh_rounded)
                      /*IconButton.filled(
                  onPressed: () {}, icon: const Icon(Icons.refresh_rounded))*/
                      /*FilledButton.icon(
                  onPressed: () => {},
                  icon: Icon(Icons.refresh_rounded),
                  label: Text('Refresh'))*/
                    ],
                  ),
                  const SizedBox(height: 10),
                ] +
                (bigScreen
                    ? [Expanded(child: ListView(children: txes))]
                    : txes)));
  }
}
