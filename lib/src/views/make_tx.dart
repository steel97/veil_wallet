// ignore_for_file: use_build_context_synchronously
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/scan_qr.dart';

class MakeTx extends StatefulWidget {
  final String? address;
  final String? amount;
  const MakeTx({super.key, this.address, this.amount});

  @override
  MakeTxState createState() {
    return MakeTxState();
  }
}

class MakeTxState extends State<MakeTx> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  bool _substractFeeFromAmount = false;
  String _availableAmount = '...';

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      _recipientController.text = widget.address!;
    }

    if (widget.amount != null) {
      _amountController.text = widget.amount!;
    }

    var addr = context.read<WalletState>().selectedAddress;
    var addrEl = context
        .read<WalletState>()
        .ownedAddresses
        .firstWhere((element) => element.address == addr);

    updateAvailableBalance(addrEl.accountType).then((value) => {
          setState(() {
            _availableAmount = value;
          })
        });
  }

  Future<String> updateAvailableBalance(AccountType type) async {
    return WalletHelper.formatAmount(
        await WalletHelper.getAvailableBalance(accountType: type));
  }

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.newTransactionTitle,
        back: () {
          Navigator.of(context).push(_createBackRoute());
        },
        child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: ListView(children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                        validator: (value) {
                          return WalletHelper.verifyAddress(value ?? '')
                              ? null
                              : AppLocalizations.of(context)
                                  ?.makeTxVerifyInvalidAddress;
                        },
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 0.0),
                          border: const UnderlineInputBorder(),
                          hintText: AppLocalizations.of(context)
                              ?.recipientAddressHint,
                          label: Text(
                              AppLocalizations.of(context)?.recipientAddress ??
                                  stringNotFoundText),
                          suffixIcon: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(_createScanQRRoute());
                            },
                            icon: const Icon(Icons.qr_code_scanner_rounded),
                          ),
                        ),
                        controller: _recipientController)),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: false),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)
                                ?.makeTxVerifyAmountCantBeEmpty;
                          }
                          try {
                            var val = double.parse(value);
                            if (val <= 0) {
                              return AppLocalizations.of(context)
                                  ?.makeTxVerifyAmountMustNotBeNegative;
                            }

                            if (double.parse(_availableAmount) <
                                val +
                                    (_substractFeeFromAmount
                                        ? 0
                                        : WalletHelper.getFee())) {
                              return AppLocalizations.of(context)
                                  ?.makeTxVerifyAmountNotEnough;
                            }

                            return null;
                          } catch (e) {
                            return AppLocalizations.of(context)
                                ?.makeTxVerifyAmountInvalid;
                          }
                        },
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 0.0),
                            border: const UnderlineInputBorder(),
                            hintText: AppLocalizations.of(context)
                                ?.sendAmountHint(_availableAmount),
                            label: Text(
                                AppLocalizations.of(context)?.sendAmount ??
                                    stringNotFoundText),
                            suffixText: '~30\$'),
                        controller: _amountController)),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                      ?.substractFeeFromAmount ??
                                  stringNotFoundText,
                              style: const TextStyle(fontSize: 16)),
                          Switch(
                              value: _substractFeeFromAmount,
                              onChanged: (val) {
                                setState(() {
                                  _substractFeeFromAmount = val;
                                });
                              }),
                        ])),
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(45)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var addr =
                                context.read<WalletState>().selectedAddress;
                            var addrEl = context
                                .read<WalletState>()
                                .ownedAddresses
                                .firstWhere(
                                    (element) => element.address == addr);
                            var tx = await WalletHelper.buildTransaction(
                                addrEl.accountType,
                                double.parse(_amountController.text),
                                _recipientController.text,
                                substractFee: _substractFeeFromAmount);

                            if (tx == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                            ?.transactionAlertTitle ??
                                        stringNotFoundText),
                                    content: Text(AppLocalizations.of(context)
                                            ?.transactionAlertErrorGeneric ??
                                        stringNotFoundText),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.alertOkAction ??
                                                  stringNotFoundText)),
                                    ],
                                  );
                                },
                              );
                            } else {
                              var amount = WalletHelper.toDisplayValue(tx
                                  .amountSent
                                  .toDouble()); //double.parse(_amountController.text);
                              var fee = WalletHelper.toDisplayValue(
                                  tx.fee.toDouble());

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                            ?.transactionAlertTitle ??
                                        stringNotFoundText),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                        ?.transactionSummaryRecipient ??
                                                    stringNotFoundText,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                  width: 10, height: 1),
                                              Expanded(
                                                  child: ExtendedText(
                                                _recipientController.text,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                overflowWidget:
                                                    const TextOverflowWidget(
                                                  position: TextOverflowPosition
                                                      .middle,
                                                  align:
                                                      TextOverflowAlign.center,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        '\u2026',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                        ?.transactionSummaryAmount ??
                                                    stringNotFoundText,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                  width: 10, height: 1),
                                              Text(WalletHelper.formatAmount(
                                                  amount))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                        ?.transactionSummaryFee ??
                                                    stringNotFoundText,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                  width: 10, height: 1),
                                              Text(WalletHelper.formatAmount(
                                                  fee))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                        ?.transactionSummaryTotal ??
                                                    stringNotFoundText,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                  width: 10, height: 1),
                                              Text(WalletHelper.formatAmount(
                                                  fee + amount))
                                            ],
                                          )
                                        ]),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.alertCancelAction ??
                                                  stringNotFoundText)),
                                      TextButton(
                                          onPressed: () async {
                                            // send transaction here
                                            var txid = await WalletHelper
                                                .publishTransaction(
                                                    addrEl.accountType,
                                                    tx.txdata!);

                                            Navigator.of(context).pop();

                                            if (txid == null) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: Text(AppLocalizations
                                                                    .of(context)
                                                                ?.transactionAlertTitle ??
                                                            stringNotFoundText),
                                                        content: Text(AppLocalizations
                                                                    .of(context)
                                                                ?.transactionAlertErrorSendGeneric ??
                                                            stringNotFoundText),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.alertOkAction ??
                                                                  stringNotFoundText)),
                                                        ]);
                                                  });
                                            } else {
                                              // tx successfully sent
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: Text(AppLocalizations
                                                                    .of(context)
                                                                ?.transactionAlertTitle ??
                                                            stringNotFoundText),
                                                        content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.transactionAlertSent ??
                                                                  stringNotFoundText),
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    Clipboard.setData(ClipboardData(
                                                                            text:
                                                                                txid))
                                                                        .then((value) =>
                                                                            {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(AppLocalizations.of(context)?.copiedText ?? stringNotFoundText),
                                                                                ),
                                                                              )
                                                                            });
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .copy_rounded),
                                                                  label:
                                                                      ExtendedText(
                                                                    txid,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    overflowWidget:
                                                                        const TextOverflowWidget(
                                                                      position:
                                                                          TextOverflowPosition
                                                                              .middle,
                                                                      align: TextOverflowAlign
                                                                          .center,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            '\u2026',
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ))
                                                            ]),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                // back
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                        _createBackRoute());
                                                              },
                                                              child: Text(AppLocalizations.of(
                                                                          context)
                                                                      ?.alertOkAction ??
                                                                  stringNotFoundText)),
                                                        ]);
                                                  });
                                            }
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.alertSendAction ??
                                                  stringNotFoundText))
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text(
                            AppLocalizations.of(context)?.sendCoinsNextAction ??
                                stringNotFoundText)))
              ]),
            )));
  }
}

Route _createScanQRRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const ScanQR(),
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

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Home();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  });
}
