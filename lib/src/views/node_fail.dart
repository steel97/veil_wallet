import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/settings.dart';

class NodeFail extends StatefulWidget {
  const NodeFail({super.key});

  @override
  State<NodeFail> createState() => _NodeFailState();
}

class _NodeFailState extends State<NodeFail> {
  bool _reloadLoading = false;

  @override
  Widget build(BuildContext context) {
    return BackLayout(
        title: AppLocalizations.of(context)?.nodeFailedTitle,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Text(
                        AppLocalizations.of(context)?.nodeFailedDescription ??
                            stringNotFoundText,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center)),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _reloadLoading
                        ? null
                        : () async {
                            setState(() {
                              _reloadLoading = true;
                            });

                            WidgetsBinding.instance
                                .scheduleFrameCallback((_) async {
                              try {
                                // ignore: use_build_context_synchronously
                                await WalletHelper.prepareHomePage(context);
                                BaseStaticState.prevNodeFailSceren =
                                    Screen.notset;
                                WidgetsBinding.instance
                                    .scheduleFrameCallback((_) {
                                  Navigator.of(context)
                                      .push(_createHomeRoute());
                                });
                                // ignore: empty_catches
                              } catch (e) {
                                WidgetsBinding.instance
                                    .scheduleFrameCallback((_) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text(AppLocalizations.of(
                                                        context)
                                                    ?.nodeFailedAlertTitle ??
                                                stringNotFoundText),
                                            content: Container(
                                                constraints: const BoxConstraints(
                                                    maxWidth:
                                                        responsiveMaxDialogWidth),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(AppLocalizations.of(
                                                                  context)
                                                              ?.nodeFailedAlertDescription ??
                                                          stringNotFoundText)
                                                    ])),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                      AppLocalizations.of(
                                                                  context)
                                                              ?.alertOkAction ??
                                                          stringNotFoundText))
                                            ]);
                                      });
                                  _reloadLoading = false;
                                });
                              }
                            });
                          },
                    icon: _reloadLoading
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
                        AppLocalizations.of(context)?.nodeFailedAction ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: _reloadLoading
                        ? null
                        : () {
                            BaseStaticState.prevNodeFailSceren =
                                Screen.nodeFail;
                            Navigator.of(context).push(_createSettingsRoute());
                          },
                    child: Text(
                        AppLocalizations.of(context)?.settingsButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                )
              ]),
        ));
  }
}

Route _createHomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
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

Route _createSettingsRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
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
