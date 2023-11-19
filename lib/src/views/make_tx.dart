// ignore_for_file: use_build_context_synchronously, empty_catches
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:veil_light_plugin/veil_light.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/functions_check.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/states/provider/dialogs_state.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/scan_qr.dart';

class _BalancesResponse {
  final String available;
  final String total;

  _BalancesResponse(this.available, this.total);
}

class MakeTx extends StatefulWidget {
  final String? address;
  final String? amount;
  const MakeTx({super.key, this.address, this.amount});

  @override
  State<MakeTx> createState() => _MakeTxState();
}

class _MakeTxState extends State<MakeTx> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  bool _substractFeeFromAmount = false;
  String _availableAmount = '...';
  String _overallAmount = '...';
  String _currentAmount = '...';
  String _curAddr = '';

  // loaders
  bool _makeTxBusy = false;

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
    _curAddr = addr;

    updateAvailableBalance(addrEl.accountType, addrEl.index).then((value) => {
          setState(() {
            _availableAmount = value.available;
            _overallAmount = value.total;
          })
        });
  }

  Future<_BalancesResponse> updateAvailableBalance(
      AccountType type, int index) async {
    var availableAmount =
        await WalletHelper.getAvailableBalance(accountType: type, index: index);
    var pending =
        await WalletHelper.getPendingBalance(accountType: type, index: index);

    return _BalancesResponse(WalletHelper.formatAmount(availableAmount),
        WalletHelper.formatAmount(availableAmount + pending));
  }

  @override
  Widget build(BuildContext context) {
    var useVerticalBar = isBigScreen(context);
    double availableAmountConverted = 0;

    if (_availableAmount != '...') {
      availableAmountConverted = double.parse(_availableAmount);
    }

    var addr = context.watch<WalletState>().selectedAddress;
    if (addr != _curAddr) {
      _curAddr = addr;
      var addrEl = context
          .read<WalletState>()
          .ownedAddresses
          .firstWhere((element) => element.address == addr);

      updateAvailableBalance(addrEl.accountType, addrEl.index).then((value) => {
            setState(() {
              _availableAmount = value.available;
              _overallAmount = value.total;
            })
          });
    }

    var container = Form(
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
                      hintText:
                          AppLocalizations.of(context)?.recipientAddressHint,
                      label: Text(
                          AppLocalizations.of(context)?.recipientAddress ??
                              stringNotFoundText),
                      suffixIcon: IconButton(
                        onPressed: checkScanQROS()
                            ? () {
                                BaseStaticState.prevScanQRScreen =
                                    Screen.makeTx;
                                Navigator.of(context)
                                    .pushReplacement(_createScanQRRoute());
                              }
                            : null,
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
                            ?.sendAmountHint(_availableAmount, _overallAmount),
                        label: Text(AppLocalizations.of(context)?.sendAmount ??
                            stringNotFoundText),
                        suffixText:
                            '~${(convertVal(_currentAmount, availableAmountConverted) * context.watch<WalletState>().conversionRate).toStringAsFixed(2)}\$'),
                    onChanged: (text) {
                      setState(() {
                        _currentAmount = text;
                      });
                    },
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
                child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _makeTxBusy
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            setState(() {
                              _makeTxBusy = true;
                            });

                            BuildTransactionResult? tx;
                            var addr =
                                context.read<WalletState>().selectedAddress;
                            var addrEl = context
                                .read<WalletState>()
                                .ownedAddresses
                                .firstWhere(
                                    (element) => element.address == addr);

                            try {
                              tx = await WalletHelper.buildTransaction(
                                  addrEl.accountType,
                                  addrEl.index,
                                  double.parse(_amountController.text),
                                  _recipientController.text,
                                  substractFee: _substractFeeFromAmount);
                            } catch (e) {}
                            setState(() {
                              _makeTxBusy = false;
                            });

                            if (tx == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(AppLocalizations.of(context)
                                            ?.transactionAlertTitle ??
                                        stringNotFoundText),
                                    content: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: responsiveMaxDialogWidth),
                                        child: Text(AppLocalizations.of(context)
                                                ?.transactionAlertErrorGeneric ??
                                            stringNotFoundText)),
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
                                    content: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: responsiveMaxDialogWidth),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                            ?.transactionSummaryRecipient ??
                                                        stringNotFoundText,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                      width: 10, height: 1),
                                                  Expanded(
                                                      child: ExtendedText(
                                                    _recipientController.text,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    overflowWidget:
                                                        const TextOverflowWidget(
                                                      position:
                                                          TextOverflowPosition
                                                              .middle,
                                                      align: TextOverflowAlign
                                                          .center,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                            ?.transactionSummaryAmount ??
                                                        stringNotFoundText,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                      width: 10, height: 1),
                                                  Text(
                                                      WalletHelper.formatAmount(
                                                          amount))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                            ?.transactionSummaryFee ??
                                                        stringNotFoundText,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                      width: 10, height: 1),
                                                  Text(
                                                      WalletHelper.formatAmount(
                                                          fee))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                            ?.transactionSummaryTotal ??
                                                        stringNotFoundText,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                      width: 10, height: 1),
                                                  Text(
                                                      WalletHelper.formatAmount(
                                                          fee + amount))
                                                ],
                                              )
                                            ])),
                                    actions: [
                                      TextButton(
                                          onPressed: context
                                                  .watch<DialogsState>()
                                                  .sendTxActive
                                              ? null
                                              : () {
                                                  Navigator.of(context).pop();
                                                },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.alertCancelAction ??
                                                  stringNotFoundText)),
                                      TextButton.icon(
                                          icon: context
                                                  .watch<DialogsState>()
                                                  .sendTxActive
                                              ? Container(
                                                  width: 24,
                                                  height: 24,
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : const SizedBox(
                                                  width: 1, height: 1),
                                          onPressed:
                                              context
                                                      .watch<DialogsState>()
                                                      .sendTxActive
                                                  ? null
                                                  : () async {
                                                      // send transaction here
                                                      context
                                                          .read<DialogsState>()
                                                          .setSendTxActive(
                                                              true);

                                                      String? txid;
                                                      try {
                                                        txid = await WalletHelper
                                                            .publishTransaction(
                                                                addrEl
                                                                    .accountType,
                                                                addrEl.index,
                                                                tx!.txdata!);

                                                        Navigator.of(context)
                                                            .pop();
                                                      } catch (e) {}

                                                      WidgetsBinding.instance
                                                          .scheduleFrameCallback(
                                                              (_) {
                                                        context
                                                            .read<
                                                                DialogsState>()
                                                            .setSendTxActive(
                                                                false);
                                                      });

                                                      if (txid == null) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                  title: Text(AppLocalizations.of(
                                                                              context)
                                                                          ?.transactionAlertTitle ??
                                                                      stringNotFoundText),
                                                                  content: Container(
                                                                      constraints: const BoxConstraints(
                                                                          maxWidth:
                                                                              responsiveMaxDialogWidth),
                                                                      child: Text(
                                                                          AppLocalizations.of(context)?.transactionAlertErrorSendGeneric ??
                                                                              stringNotFoundText)),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(AppLocalizations.of(context)?.alertOkAction ??
                                                                            stringNotFoundText)),
                                                                  ]);
                                                            });
                                                      } else {
                                                        // tx successfully sent
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                  title: Text(AppLocalizations.of(
                                                                              context)
                                                                          ?.transactionAlertTitle ??
                                                                      stringNotFoundText),
                                                                  content:
                                                                      Container(
                                                                          constraints: const BoxConstraints(
                                                                              maxWidth:
                                                                                  responsiveMaxDialogWidth),
                                                                          child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Text(AppLocalizations.of(context)?.transactionAlertSent ?? stringNotFoundText),
                                                                                TextButton.icon(
                                                                                    onPressed: () {
                                                                                      Clipboard.setData(ClipboardData(text: txid!)).then((value) => {
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackBar(
                                                                                                content: Text(AppLocalizations.of(context)?.copiedText ?? stringNotFoundText),
                                                                                              ),
                                                                                            )
                                                                                          });
                                                                                    },
                                                                                    icon: const Icon(Icons.copy_rounded),
                                                                                    label: ExtendedText(
                                                                                      txid!,
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
                                                                                              style: TextStyle(fontSize: 14),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      style: const TextStyle(fontSize: 14),
                                                                                    ))
                                                                              ])),
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          // back
                                                                          Navigator.of(context)
                                                                              .push(_createBackRoute(useVerticalBar));
                                                                        },
                                                                        child: Text(AppLocalizations.of(context)?.alertOkAction ??
                                                                            stringNotFoundText)),
                                                                  ]);
                                                            });
                                                      }
                                                    },
                                          label: Text(
                                              AppLocalizations.of(context)
                                                      ?.alertSendAction ??
                                                  stringNotFoundText))
                                    ],
                                  );
                                },
                              );
                            }
                          },
                    icon: _makeTxBusy
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const SizedBox(width: 1, height: 1),
                    label: Text(
                        AppLocalizations.of(context)?.sendCoinsNextAction ??
                            stringNotFoundText)))
          ]),
        ));

    return PopScope(
        child: useVerticalBar
            ? MainLayout(
                overrideTitle:
                    AppLocalizations.of(context)?.newTransactionTitle,
                child: container)
            : BackLayout(
                title: AppLocalizations.of(context)?.newTransactionTitle,
                back: () {
                  Navigator.of(context).push(_createBackRoute(useVerticalBar));
                },
                child: container));
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

Route _createBackRoute(bool useVerticalBar) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Home();
  }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (useVerticalBar) {
      return child;
    }

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

double convertVal(String curVal, double defVal) {
  try {
    return double.parse(curVal);
  } catch (e) {}
  return defVal;
}
