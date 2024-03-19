// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veil_wallet/src/core/constants.dart';
import 'package:veil_wallet/src/core/func_checker.dart';
import 'package:veil_wallet/src/core/locale_entry.dart';
import 'package:veil_wallet/src/core/node_entry.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/core/wallet_bg_tasks.dart';
import 'package:veil_wallet/src/core/wallet_helper.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/provider/wallet_state.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/storage/storage_item.dart';
import 'package:veil_wallet/src/storage/storage_service.dart';
import 'package:veil_wallet/src/views/about.dart';
import 'package:veil_wallet/src/views/auth.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_wallet/src/views/node_fail.dart';
import 'package:veil_wallet/src/views/setup_biometrics.dart';
import 'package:veil_wallet/src/views/welcome.dart';
import 'package:veil_light_plugin/veil_light.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  final _nodeUrlController = TextEditingController();
  final _nodeAuthController = TextEditingController();
  final _explorerUrlController = TextEditingController();
  final _txExplorerUrlController = TextEditingController();
  bool _useCustomConversionRate = false;
  final _conversionApiController = TextEditingController();
  final _conversionRateController = TextEditingController();
  bool _useMinimumUTXOs = false;
  bool _isBiometricsActive = false;
  bool _darkMode = false;
  String _locale = '';
  String _localeTmp = '';
  String _selectedNode = defaultNodeAddress;

  @override
  void initState() {
    super.initState();
    // Fetch user data from API using BuildContext
    _nodeUrlController.text = BaseStaticState.nodeAddress;
    _nodeAuthController.text = BaseStaticState.nodeAuth;
    _explorerUrlController.text = BaseStaticState.explorerAddress;
    _txExplorerUrlController.text = BaseStaticState.txExplorerAddress;
    _useCustomConversionRate = BaseStaticState.setConversionRateManually;
    _conversionApiController.text = BaseStaticState.conversionApiAddress;
    _conversionRateController.text = BaseStaticState.conversionCustomRate;
    _useMinimumUTXOs = BaseStaticState.useMinimumUTXOs;

    setState(() {
      _isBiometricsActive = BaseStaticState.biometricsActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == '') {
      final Locale appLocale = Localizations.localeOf(context);
      _locale = appLocale.languageCode;
    }

    var curLocale =
        knownLanguages.firstWhere((locale) => locale.code == _locale);

    _darkMode = context.read<WalletState>().darkMode;

    var biometricsPossibleFeature = checkBiometricsSupport();

    List<Widget> authActions = [];

    if (BaseStaticState.prevScreen != Screen.welcome) {
      if (_isBiometricsActive) {
        authActions.add(FutureBuilder(
            future: biometricsPossibleFeature,
            builder: (BuildContext context,
                AsyncSnapshot<bool> biometricsAvailable) {
              if (!(biometricsAvailable.data ?? false)) {
                return const SizedBox(width: 1, height: 1);
              }
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: OutlinedButton.icon(
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      foregroundColor: Theme.of(context).colorScheme.error),
                  onPressed: () async {
                    var auth = LocalAuthentication();

                    try {
                      var didAuthenticate = await auth.authenticate(
                          localizedReason: AppLocalizations.of(context)
                                  ?.biometricsRemoveReason ??
                              stringNotFoundText,
                          options: const AuthenticationOptions(
                              useErrorDialogs: true));
                      if (didAuthenticate) {
                        BaseStaticState.biometricsTimestamp =
                            DateTime.now().millisecondsSinceEpoch;
                        var storageService = StorageService();
                        await storageService.writeSecureData(StorageItem(
                            prefsBiometricsEnabled, false.toString()));
                        setState(() {
                          _isBiometricsActive = false;
                          BaseStaticState.biometricsActive = false;
                        });
                      }
                    } on PlatformException {}
                  },
                  icon: const Icon(Icons.fingerprint_rounded),
                  label: Text(
                      AppLocalizations.of(context)?.removeBiometricsButton ??
                          stringNotFoundText),
                ),
              );
            }));
      } else {
        authActions.add(FutureBuilder(
            future: biometricsPossibleFeature,
            builder: (BuildContext context,
                AsyncSnapshot<bool> biometricsAvailable) {
              if (!(biometricsAvailable.data ?? false)) {
                return const SizedBox(width: 1, height: 1);
              }
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: OutlinedButton.icon(
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(45)),
                  onPressed: () {
                    Navigator.of(context).push(_setupBiometricsRoute());
                  },
                  icon: const Icon(Icons.fingerprint_rounded),
                  label: Text(
                      AppLocalizations.of(context)?.setupBiometricsButton ??
                          stringNotFoundText),
                ),
              );
            }));
      }

      authActions.add(SizedBox(
          width: double.infinity,
          child: Row(children: [
            Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 5, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {
                      var mnemonic = Lightwallet.generateMnemonic();
                      BaseStaticState.newWalletWords = mnemonic;

                      BaseStaticState.prevScreen = Screen.settings;
                      Navigator.of(context).push(_createNewRoute());
                    },
                    icon: const Icon(Icons.new_label_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.createWalletButton ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 10, 10),
                  child: OutlinedButton.icon(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {
                      BaseStaticState.prevScreen = Screen.settings;
                      BaseStaticState.importWalletWords = [];
                      Navigator.of(context).push(_createImportRoute());
                    },
                    icon: const Icon(Icons.upload_rounded),
                    label: Text(
                        AppLocalizations.of(context)?.importWallet ??
                            stringNotFoundText,
                        overflow: TextOverflow.ellipsis),
                  ),
                ))
          ])));

      authActions.add(Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: OutlinedButton.icon(
          style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(45),
              foregroundColor: Theme.of(context).colorScheme.error),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text(
                          AppLocalizations.of(context)?.deleteAllDataTitle ??
                              stringNotFoundText),
                      content: Container(
                          constraints: const BoxConstraints(
                              maxWidth: responsiveMaxDialogWidth),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(AppLocalizations.of(context)
                                    ?.deleteAllDataConfirmation ??
                                stringNotFoundText)
                          ])),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                AppLocalizations.of(context)?.noAction ??
                                    stringNotFoundText)),
                        TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();

                              // delete all secret data
                              var storageService = StorageService();
                              await storageService.deleteAllSecureData();

                              // delete shared prefs
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();

                              WidgetsBinding.instance
                                  .scheduleFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)
                                            ?.deleteAllDataNotification ??
                                        stringNotFoundText),
                                  ),
                                );

                                // move to welcome screen
                                Navigator.of(context)
                                    .push(_createWelcomeRoute());
                              });
                            },
                            child: Text(
                                AppLocalizations.of(context)?.yesAction ??
                                    stringNotFoundText))
                      ]);
                });
          },
          icon: const Icon(Icons.delete_forever_rounded),
          label: Text(AppLocalizations.of(context)?.deleteAllData ??
              stringNotFoundText),
        ),
      ));
    }

    List<Widget> conversionWidgets = [];
    if (_useCustomConversionRate) {
      conversionWidgets.add(Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextFormField(
            validator: (value) {
              try {
                var _ = double.parse(value ?? '');
                return null;
              } catch (e) {}
              return '';
            },
            enableSuggestions: true,
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 0.0),
              border: const UnderlineInputBorder(),
              hintText:
                  AppLocalizations.of(context)?.conversionRateInputFieldHint,
              label: Text(
                  AppLocalizations.of(context)?.conversionRateInputField ??
                      stringNotFoundText,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              suffixIcon: IconButton(
                onPressed: () {
                  _conversionRateController.text = '0.00';
                },
                icon: Icon(
                  Icons.restore_rounded,
                  semanticLabel: AppLocalizations.of(context)
                      ?.resetConversionRateSemantics,
                ),
              ),
            ),
            controller: _conversionRateController,
          )));
    } else {
      conversionWidgets.add(Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              }
              return value.startsWith('http://') || value.startsWith('https://')
                  ? null
                  : '';
            },
            enableSuggestions: true,
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 0.0),
              border: const UnderlineInputBorder(),
              hintText:
                  AppLocalizations.of(context)?.conversionApiInputFieldHint,
              label: Text(
                  AppLocalizations.of(context)?.conversionApiInputField ??
                      stringNotFoundText,
                  style: const TextStyle(overflow: TextOverflow.ellipsis)),
              suffixIcon: IconButton(
                onPressed: () {
                  _conversionApiController.text = defaultConversionApiUrl;
                },
                icon: Icon(
                  Icons.restore_rounded,
                  semanticLabel:
                      AppLocalizations.of(context)?.resetConversionApiSemantics,
                ),
              ),
            ),
            controller: _conversionApiController,
          )));
    }

    return PopScope(
        canPop: false,
        onPopInvoked: (invoked) {
          Navigator.of(context).push(_createBackRoute());
        },
        child: BackLayout(
            title: AppLocalizations.of(context)?.settingsTitle,
            back: () {
              Navigator.of(context).push(_createBackRoute());
            },
            child: Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      }
                                      return value.startsWith('http://') ||
                                              value.startsWith('https://')
                                          ? null
                                          : '';
                                    },
                                    enableSuggestions: true,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      border: const UnderlineInputBorder(),
                                      hintText: AppLocalizations.of(context)
                                          ?.nodeUrlInputFieldHint,
                                      label: Text(
                                          AppLocalizations.of(context)
                                                  ?.nodeUrlInputField ??
                                              stringNotFoundText,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis)),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          //_nodeUrlController.text = defaultNodeAddress;
                                          _selectedNode =
                                              _nodeUrlController.text;

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text(AppLocalizations
                                                                .of(context)
                                                            ?.nodeSelectionTitle ??
                                                        stringNotFoundText),
                                                    content: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth:
                                                                    responsiveMaxDialogWidth),
                                                        child: StatefulBuilder(
                                                            // You need this, notice the parameters below:
                                                            builder: (BuildContext
                                                                    context,
                                                                StateSetter
                                                                    setState) {
                                                          List<Widget> nodes =
                                                              List.empty(
                                                                  growable:
                                                                      true);
                                                          for (NodeEntry node
                                                              in knownNodes) {
                                                            nodes.add(ListTile(
                                                              title: Text(
                                                                  node.name),
                                                              leading:
                                                                  Radio<String>(
                                                                value: node.url,
                                                                groupValue:
                                                                    _selectedNode,
                                                                onChanged: (String?
                                                                    value) async {
                                                                  setState(() {
                                                                    _selectedNode =
                                                                        value ??
                                                                            defaultNodeAddress;
                                                                  });
                                                                },
                                                              ),
                                                            ));
                                                          }

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: nodes,
                                                          );
                                                        })),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(AppLocalizations
                                                                      .of(context)
                                                                  ?.alertCancelAction ??
                                                              stringNotFoundText)),
                                                      TextButton(
                                                          onPressed: () async {
                                                            WidgetsBinding
                                                                .instance
                                                                .scheduleFrameCallback(
                                                                    (_) {
                                                              _nodeUrlController
                                                                      .text =
                                                                  _selectedNode;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child: Text(AppLocalizations
                                                                      .of(context)
                                                                  ?.saveButton ??
                                                              stringNotFoundText)),
                                                    ]);
                                              });
                                        },
                                        icon: Icon(
                                          Icons.miscellaneous_services_rounded,
                                          semanticLabel:
                                              AppLocalizations.of(context)
                                                  ?.nodeSelectionTitle,
                                        ),
                                      ),
                                    ),
                                    controller: _nodeUrlController)),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                    enableSuggestions: true,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(bottom: 0.0),
                                        border: const UnderlineInputBorder(),
                                        hintText: AppLocalizations.of(context)
                                            ?.basicAuthInputFieldHint,
                                        label: Text(
                                            AppLocalizations.of(context)
                                                    ?.basicAuthInputField ??
                                                stringNotFoundText,
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis))),
                                    controller: _nodeAuthController)),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return value.startsWith('http://') ||
                                            value.startsWith('https://')
                                        ? null
                                        : '';
                                  },
                                  enableSuggestions: true,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 0.0),
                                    border: const UnderlineInputBorder(),
                                    hintText: AppLocalizations.of(context)
                                        ?.explorerUrlInputFieldHint,
                                    label: Text(
                                        AppLocalizations.of(context)
                                                ?.explorerUrlInputField ??
                                            stringNotFoundText,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis)),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _explorerUrlController.text =
                                            defaultExplorerAddress;
                                      },
                                      icon: Icon(
                                        Icons.restore_rounded,
                                        semanticLabel:
                                            AppLocalizations.of(context)
                                                ?.resetExplorerIconSemantics,
                                      ),
                                    ),
                                  ),
                                  controller: _explorerUrlController,
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return value.startsWith('http://') ||
                                            value.startsWith('https://')
                                        ? null
                                        : '';
                                  },
                                  enableSuggestions: true,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 0.0),
                                    border: const UnderlineInputBorder(),
                                    hintText: AppLocalizations.of(context)
                                        ?.explorerTxInputFieldHint,
                                    label: Text(
                                        AppLocalizations.of(context)
                                                ?.explorerTxInputField ??
                                            stringNotFoundText,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis)),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        _txExplorerUrlController.text =
                                            defaultTxExplorerAddress;
                                      },
                                      icon: Icon(
                                        Icons.restore_rounded,
                                        semanticLabel: AppLocalizations.of(
                                                context)
                                            ?.resetExplorerTxesIconSemantics,
                                      ),
                                    ),
                                  ),
                                  controller: _txExplorerUrlController,
                                )),
                            // conversion api
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                                  ?.useCustomConversionRate ??
                                              stringNotFoundText,
                                          style: const TextStyle(fontSize: 16)),
                                      Switch(
                                          value: _useCustomConversionRate,
                                          onChanged: (val) {
                                            setState(() {
                                              _useCustomConversionRate = val;
                                            });
                                          }),
                                    ])),
                          ] +
                          conversionWidgets +
                          [
                            // end
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                                  ?.useMinimumUTXOs ??
                                              stringNotFoundText,
                                          style: const TextStyle(fontSize: 16)),
                                      Switch(
                                          value: _useMinimumUTXOs,
                                          onChanged: (val) {
                                            setState(() {
                                              _useMinimumUTXOs = val;
                                            });
                                          }),
                                    ])),
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                                  ?.darkMode ??
                                              stringNotFoundText,
                                          style: const TextStyle(fontSize: 16)),
                                      Switch(
                                          value: _darkMode,
                                          onChanged: (val) async {
                                            setState(() {
                                              _darkMode = val;
                                            });

                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool(
                                                prefsDarkMode, _darkMode);

                                            WidgetsBinding.instance
                                                .scheduleFrameCallback((_) {
                                              context
                                                  .read<WalletState>()
                                                  .setDarkMode(_darkMode);
                                            });
                                          }),
                                    ])),
                          ] +
                          [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: OutlinedButton.icon(
                                  style: FilledButton.styleFrom(
                                      minimumSize: const Size.fromHeight(45)),
                                  onPressed: () {
                                    _localeTmp = _locale;
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Text(AppLocalizations.of(
                                                          context)
                                                      ?.localeSelectionTitle ??
                                                  stringNotFoundText),
                                              content: Container(
                                                  constraints: const BoxConstraints(
                                                      maxWidth:
                                                          responsiveMaxDialogWidth),
                                                  child: StatefulBuilder(
                                                      // You need this, notice the parameters below:
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                    List<Widget> locales =
                                                        List.empty(
                                                            growable: true);
                                                    for (LocaleEntry locale
                                                        in knownLanguages) {
                                                      locales.add(ListTile(
                                                        title:
                                                            Text(locale.name),
                                                        leading: Radio<String>(
                                                          value: locale.code,
                                                          groupValue:
                                                              _localeTmp,
                                                          onChanged: (String?
                                                              value) async {
                                                            setState(() {
                                                              _localeTmp =
                                                                  value ?? 'en';
                                                            });
                                                          },
                                                        ),
                                                      ));
                                                    }

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: locales,
                                                    );
                                                  })),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(AppLocalizations
                                                                .of(context)
                                                            ?.alertCancelAction ??
                                                        stringNotFoundText)),
                                                TextButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        _locale = _localeTmp;
                                                      });
                                                      context
                                                          .read<WalletState>()
                                                          .setLocale(Locale
                                                              .fromSubtags(
                                                                  languageCode:
                                                                      _localeTmp));
                                                      final SharedPreferences
                                                          prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          prefsLocaleStorage,
                                                          _localeTmp);
                                                      WidgetsBinding.instance
                                                          .scheduleFrameCallback(
                                                              (_) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Text(AppLocalizations
                                                                .of(context)
                                                            ?.saveButton ??
                                                        stringNotFoundText)),
                                              ]);
                                        });
                                  },
                                  icon: const Icon(Icons.language_rounded),
                                  label: Text(curLocale.name)),
                            ),
                          ] +
                          authActions +
                          [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(45)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // done
                                    BaseStaticState.nodeAddress =
                                        _nodeUrlController.text;
                                    BaseStaticState.nodeAuth =
                                        _nodeAuthController.text;
                                    BaseStaticState.explorerAddress =
                                        _explorerUrlController.text;
                                    BaseStaticState.txExplorerAddress =
                                        _txExplorerUrlController.text;
                                    BaseStaticState.setConversionRateManually =
                                        _useCustomConversionRate;
                                    BaseStaticState.conversionApiAddress =
                                        _conversionApiController.text;
                                    BaseStaticState.conversionCustomRate =
                                        _conversionRateController.text;
                                    BaseStaticState.useMinimumUTXOs =
                                        _useMinimumUTXOs;

                                    RpcRequester.NODE_URL =
                                        BaseStaticState.nodeAddress;
                                    RpcRequester.NODE_PASSWORD =
                                        BaseStaticState.nodeAuth;

                                    var storageService = StorageService();
                                    await storageService.writeSecureData(
                                        StorageItem(prefsSettingsNodeUrl,
                                            BaseStaticState.nodeAddress));
                                    await storageService.writeSecureData(
                                        StorageItem(prefsSettingsNodeAuth,
                                            BaseStaticState.nodeAuth));
                                    await storageService.writeSecureData(
                                        StorageItem(prefsSettingsExplorerUrl,
                                            BaseStaticState.explorerAddress));
                                    await storageService.writeSecureData(
                                        StorageItem(prefsSettingsExplorerTxUrl,
                                            BaseStaticState.txExplorerAddress));
                                    await storageService.writeSecureData(
                                        StorageItem(
                                            prefsSettingsConversionManually,
                                            BaseStaticState
                                                .setConversionRateManually
                                                .toString()));
                                    await storageService.writeSecureData(
                                        StorageItem(
                                            prefsSettingsConversionApiUrl,
                                            BaseStaticState
                                                .conversionApiAddress));
                                    await storageService.writeSecureData(
                                        StorageItem(
                                            prefsSettingsConversionRate,
                                            BaseStaticState
                                                .conversionCustomRate));
                                    await storageService.writeSecureData(
                                        StorageItem(
                                            prefsSettingsUseMinimumUTXOs,
                                            BaseStaticState.useMinimumUTXOs
                                                .toString()));

                                    WalletBgTasks
                                        .fetchConversionRateIfPossible();
                                    WalletHelper.loadConversionRate();

                                    /*WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.of(context)
                                      .push(_createBackRoute());
                                });*/
                                    WidgetsBinding.instance
                                        .scheduleFrameCallback((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)
                                                      ?.settingsSaved ??
                                                  stringNotFoundText),
                                        ),
                                      );
                                    });
                                  }
                                },
                                icon: const Icon(Icons.save_rounded),
                                label: Text(
                                    AppLocalizations.of(context)?.saveButton ??
                                        stringNotFoundText,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(45)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(_createAboutRoute());
                                },
                                icon: const Icon(Icons.info_rounded),
                                label: Text(
                                    AppLocalizations.of(context)?.aboutButton ??
                                        stringNotFoundText,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ]),
                ))));
  }
}

Route _createBackRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    if (BaseStaticState.prevScreen == Screen.home ||
        BaseStaticState.useHomeBack) {
      return const Home();
    }

    if (BaseStaticState.prevNodeFailSceren == Screen.auth) {
      return const Auth();
    }

    if (BaseStaticState.prevNodeFailSceren == Screen.nodeFail) {
      return const NodeFail();
    }

    return const Welcome();
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

Route _createNewRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const NewWalletSaveSeed();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createImportRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const ImportSeed();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createAboutRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const About();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _setupBiometricsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SetupBiometrics();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createWelcomeRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
    return const Welcome();
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
