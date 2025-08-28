// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get title => 'Veil piniginė';

  @override
  String get welcomeTitle => 'Sveiki!';

  @override
  String get welcomeDescription => 'Importuokite arba sukurkite piniginę';

  @override
  String get createWallet => 'Sukurti';

  @override
  String get importWallet => 'Importas';

  @override
  String get settingsButton => 'Nustatymai';

  @override
  String get saveSeedPhraseTitle => 'Nauja piniginė';

  @override
  String get saveSeedPhraseDescription =>
      'Įrašykite naujosios piniginės seed frazę:';

  @override
  String get nextButton => 'Toliau';

  @override
  String get verifySeedPhraseTitle => 'Seed frazės tikrinimas';

  @override
  String get verifySeedPhraseDescription => '24 žodžių seed frazė tikrinimas:';

  @override
  String get createWalletButton => 'Sukurti piniginę';

  @override
  String get walletNameInputField => 'Piniginės pavadinimas:';

  @override
  String get walletNameInputFieldHint => 'Piniginės pavadinimas';

  @override
  String get importSeedTitle => 'Importuoti seed frazę';

  @override
  String get importSeedDescription => 'Importuoti 24 žodžių seed frazę:';

  @override
  String get walletAdvancedButton => 'Papildomos nustatymai';

  @override
  String get walletAdvancedTitle => 'Papildomos nustatymai';

  @override
  String get walletEncryptionPasswordInputField =>
      'Šifravimo slaptažodis (jeigu yra):';

  @override
  String get walletEncryptionPasswordInputFieldHint => 'Šifravimo slaptažodis';

  @override
  String get walletEncryptionPasswordRepeatInputField =>
      'Pakartokite šifravimo slaptažodį:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'Pakartokite šifravimo slaptažodį';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'Importas $fileName';
  }

  @override
  String get saveButton => 'Įrašyti';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get nodeUrlInputField => 'Nodos adresas:';

  @override
  String get nodeUrlInputFieldHint =>
      'Lightwallet Veil nodos adresas (prasidėda iš http(s)://)';

  @override
  String get basicAuthInputField => 'Pagrindinis nodos autorizavimas:';

  @override
  String get basicAuthInputFieldHint => 'Tuščia nodai explorer';

  @override
  String get explorerUrlInputField => 'Explorer URL:';

  @override
  String get explorerUrlInputFieldHint => 'Explorer URL';

  @override
  String get explorerTxInputField => 'Tx explorer URL:';

  @override
  String get explorerTxInputFieldHint => 'Sandorio explorer URL';

  @override
  String get useMinimumUTXOs => 'Naudoti minimumą UTXOs';

  @override
  String get setupBiometricsButton => 'Nustatyti biometriniai duomenys';

  @override
  String get aboutButton => 'Apie programą';

  @override
  String get biometricsTitle => 'Piniginės apsauga';

  @override
  String get biometricsDescription =>
      'Norėdami apsaugoti savo piniginę, primygtinai rekomenduojame nustatyti šios programos biometrinį autentifikavimą';

  @override
  String get skipBiometricsButton => 'Praleisti (nerekomenduojama)';

  @override
  String get walletTitle => 'Piniginė';

  @override
  String get notificationsAction => 'Pranešimai';

  @override
  String get sendButton => 'Siųsti';

  @override
  String get receiveButton => 'Gauti';

  @override
  String get buyButton => 'Pirkti';

  @override
  String get transactionsLabel => 'Sandoriai';

  @override
  String get txTypeReceived => 'Gautas';

  @override
  String get txTypeSent => 'Išsiųstas';

  @override
  String get txTypeUnknown => 'Nežinomas';

  @override
  String get homeNavHome => 'Pradžia';

  @override
  String get homeNavExplorer => 'Explorer';

  @override
  String get homeNavScanQR => 'Skenuoti QR kodą';

  @override
  String get homeNavSettings => 'Nustatymai';

  @override
  String get homeNavWebsite => 'Svetainė';

  @override
  String get passwordsNotMatch => 'Slaptažodžiai nesutampa';

  @override
  String get seedWordCantBeEmpty => 'Seed žodis negali būti tuščias';

  @override
  String get seedWordWrong => 'Neteisingas seed žodis';

  @override
  String get seedWordNotMatch => 'Seed žodis nesutampa';

  @override
  String get aboutTitle => 'Apie programą';

  @override
  String get aboutText =>
      'Veil piniginė - Veil kriptovaliutos mobilioji piniginė.\nŠaltinio kodą rasite čia:';

  @override
  String get aboutText2 => 'Paaukojimų adresas:';

  @override
  String get copiedText => 'Nukopijuota';

  @override
  String get authenticateTitle => 'Tapatybės nustatymas';

  @override
  String get authenticateDescription =>
      'Norėdami pasiekti piniginę, patvirtinkite tapatybę';

  @override
  String get authenticateAction => 'Nustatyti tapatybę';

  @override
  String get biometricsReason => 'Prisijunkite, kad atrakinti piniginę';

  @override
  String get biometricsSetupReason =>
      'Norėdami nustatyti biometrinius duomenis, patvirtinkite savo tapatybę';

  @override
  String get biometricsRemoveReason =>
      'Norėdami ištrinti biometrinius duomenis, patvirtinkite savo tapatybę';

  @override
  String get settingsSaved => 'Nustatymai įsirãšė';

  @override
  String get removeBiometricsButton => 'Ištrinti biometrinius duomenis';

  @override
  String get loadingAppSemantics => 'Įkelimas Veil piniginė';

  @override
  String get shareTitle => 'Gauti Veil';

  @override
  String get shareDescriptionText => 'Naudokite šį QR kodą monetoms gauti';

  @override
  String get shareAction => 'Bendrinti kvadratiniu kodu';

  @override
  String get shareSubject => 'Mano kvadratinis kodas kad gauti monetui Veil';

  @override
  String shareText(String address) {
    return 'Mano Veil adresas: $address';
  }

  @override
  String get newTransactionTitle => 'Naujas sandoris';

  @override
  String get recipientAddress => 'Gavėjo adresas:';

  @override
  String get recipientAddressHint => 'Gavėjo adresas';

  @override
  String get sendAmount => 'Siunčiama suma:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'Prieinamas $amount iš $overall veil';
  }

  @override
  String get subtractFeeFromAmount => 'Iš sumos atimti mokestį';

  @override
  String get availableText => 'Galima:';

  @override
  String get sendCoinsNextAction => 'Toliau';

  @override
  String get makeTxVerifyInvalidAddress => 'Adresas neteisingas';

  @override
  String get makeTxVerifyAmountCantBeEmpty => 'Suma negali būti tuščia';

  @override
  String get makeTxVerifyAmountMustNotBeNegative =>
      'Suma negali būti mažesnė arba lygi nuliui';

  @override
  String get makeTxVerifyAmountInvalid => 'Įvesta neteisinga suma';

  @override
  String get makeTxVerifyAmountNotEnough => 'Suma didesnė nei turima';

  @override
  String get transactionAlertTitle => 'Sandoris';

  @override
  String get transactionAlertErrorGeneric =>
      'Įvyko klaida! Nepavyko sukurti sandorio';

  @override
  String get alertOkAction => 'Gerai';

  @override
  String get alertCancelAction => 'Atšaukti';

  @override
  String get alertSendAction => 'Siųsti';

  @override
  String get transactionSummaryRecipient => 'Gavėjas:';

  @override
  String get transactionSummaryAmount => 'Kiekis:';

  @override
  String get transactionSummaryFee => 'Mokestis:';

  @override
  String get transactionSummaryTotal => 'Iš viso:';

  @override
  String get transactionAlertErrorSendGeneric =>
      'Nepavyko išsiųsti sandorio! Pabandykite dar kartą';

  @override
  String get transactionAlertSent => 'Sandoris išsiųsta! Tx id:';

  @override
  String get flashlightToolip => 'Žibintelis';

  @override
  String get cameraNoPermissions => 'Programa neturi prieigos prie fotoaparato';

  @override
  String get scanQRTitle => 'Skenuoti kvadratinį kodą';

  @override
  String get loadingWalletTitle => 'Piniginė';

  @override
  String get loadingWalletDescription =>
      'Piniginės įkėlimas gali šiek tiek užtrukti, prašau palaukite';

  @override
  String get loadingAddressTitle => 'Adreso įkėlimas';

  @override
  String get loadingAddressDescription =>
      'Adreso įkėlimas gali šiek tiek užtrukti, palaukite';

  @override
  String get walletSettingsTitle => 'Piniginės nustatymai';

  @override
  String get deleteWalletAction => 'Ištrinti piniginę';

  @override
  String get deleteWalletConfirmationTitle => 'Ištrinti piniginę';

  @override
  String get deleteWalletConfirmation => 'Ar tikrai norite ištrinti piniginę?';

  @override
  String get yesAction => 'Taip';

  @override
  String get noAction => 'Ne';

  @override
  String get nodeFailedTitle => 'Klaida';

  @override
  String get nodeFailedDescription =>
      'Nepavyko prisijungti prie nodos, pabandykite dar kartą';

  @override
  String get nodeFailedAction => 'Prisijungti iš naujo';

  @override
  String get nodeFailedAlertTitle => 'Klaida';

  @override
  String get nodeFailedAlertDescription =>
      'Nepavyko prisijungti prie nodos, pabandykite dar kartą';

  @override
  String get transactionsListEmpty => 'Sandoriai nerasta arba dar neįkeltos';

  @override
  String get syncStatusSyncedSemantics => 'Adresas sinchronizuotas su noda';

  @override
  String get syncStatusScanningFailedSemantics =>
      'Nepavyko sinchronizuoti adreso';

  @override
  String get syncStatusScanningSemantics => 'Node dabar skenuoja jūsų adresą';

  @override
  String get localeSelectionTitle => 'Pasirinkti kalbą';

  @override
  String get nodeSelectionTitle => 'Galimi nodai';

  @override
  String get darkMode => 'Tamsi tema';

  @override
  String get discordInfo => 'Oficialus discord:';

  @override
  String get discordFaucetInfo =>
      '* Kai kurias monetas galite gauti per maišytuvą, kurį galima įsigyti oficialiai discorde';

  @override
  String get legalInfo => 'Teisinė informacija';

  @override
  String get legalTitle => 'Teisinė informacija';

  @override
  String get createAddress => 'Sukurti naują adresą';

  @override
  String get addressCreated => 'Sukurtas adresas';

  @override
  String get homeNavScanQRUnavailable => 'QR scanner is unavailable on desktop';

  @override
  String get sendHistoryRecent => 'Recent';

  @override
  String get noSentTransactions => 'No sent transactions found';

  @override
  String get historyLoadingSemantics => 'History loading';

  @override
  String get historyDeleted => 'History deleted';

  @override
  String get historyDeleteConfirmationTitle => 'Delete history';

  @override
  String get historyDeleteConfirmation =>
      'Are you sure you want to delete history?';

  @override
  String get deleteAllData => 'Delete all data';

  @override
  String get deleteAllDataTitle => 'Delete all data';

  @override
  String get deleteAllDataConfirmation =>
      'Are you sure you want to delete all data (all wallets, settings, history)?';

  @override
  String get deleteAllDataNotification => 'All data erased';

  @override
  String get addressBookTitle => 'Address book';

  @override
  String get addressBookSearchLabel => 'Search address';

  @override
  String get addressBookSearchHint => 'Enter address or label';

  @override
  String get addressBookSavedAddresses => 'Saved addresses';

  @override
  String get addressBookLoadingSemantics => 'Loading address book';

  @override
  String get addressBookClearConfirmationTitle => 'Clear address book';

  @override
  String get addressBookClearConfirmation =>
      'Are you sure you want to clear address book?';

  @override
  String get addressBookCleared => 'Address book cleared';

  @override
  String get addressBookRemoveSemantics => 'Ištrinti adresą iš adresų knygos';

  @override
  String get addressBookEditSemantics => 'Keisti adresą';

  @override
  String get addressBookNewAddress => 'Naujas adresas';

  @override
  String get addressBookNewAddressLabel => 'Žymė';

  @override
  String get addressBookNewAddressLabelHint => 'Žymė';

  @override
  String get addressBookNewAddressValue => 'Adresas';

  @override
  String get addressBookNewAddressValueHint => 'Adresas';

  @override
  String get addressBookNewAddressCancelButton => 'Atšaukti';

  @override
  String get addressBookNewAddressSaveButton => 'Įrašyti';

  @override
  String get addressBookNewAddressSavedNotification =>
      'Adresas pridėtas į adresų knygą';

  @override
  String get noAddressBookAddresses => 'Adresai nerasta';

  @override
  String get addressBookDeleteAddressConfirmationTitle => 'Ištrinti adresą';

  @override
  String get addressBookDeleteAddressConfirmation =>
      'Ar jūs įsitikinęs kad norite ištrinti adresą iš adresų knygos?';

  @override
  String get addressBookAddressDeleted => 'Adresas ištrintas iš adresų knygos';

  @override
  String get addressBookEditAddress => 'Keisti adresą';

  @override
  String get addressBookNoLabel => 'Numatyta';

  @override
  String get resetExplorerIconSemantics => 'Atstatyti explorer adresą';

  @override
  String get resetExplorerTxesIconSemantics =>
      'Atstatyti sandorio explorer adresą';

  @override
  String get conversionRateInputField => 'Custom conversion rate (USD):';

  @override
  String get conversionRateInputFieldHint =>
      'Veil/USD conversion rate (ex. 0.006)';

  @override
  String get resetConversionRateSemantics =>
      'Reset conversion rate default value';

  @override
  String get conversionApiInputField => 'Conversion API url:';

  @override
  String get conversionApiInputFieldHint =>
      'Should start with http:// or https://';

  @override
  String get resetConversionApiSemantics =>
      'Reset conversion API url to default value';

  @override
  String get useCustomConversionRate => 'Use custom conversion rate';
}
