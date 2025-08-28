// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class AppLocalizationsEo extends AppLocalizations {
  AppLocalizationsEo([String locale = 'eo']) : super(locale);

  @override
  String get title => 'Veil monujo';

  @override
  String get welcomeTitle => 'Bonvenon al Veil!';

  @override
  String get welcomeDescription => 'Importu ekzistantan monujon aŭ kreu novan';

  @override
  String get createWallet => 'Krei';

  @override
  String get importWallet => 'Importi';

  @override
  String get settingsButton => 'Agordoj';

  @override
  String get saveSeedPhraseTitle => 'Konservu semfrazon';

  @override
  String get saveSeedPhraseDescription =>
      'Konservu la novan semfrazon de la monujo:';

  @override
  String get nextButton => 'Sekva';

  @override
  String get verifySeedPhraseTitle => 'Konfirmu seman frazon';

  @override
  String get verifySeedPhraseDescription => 'Konfirmu la semon de 24 vortoj:';

  @override
  String get createWalletButton => 'Krei monujon';

  @override
  String get walletNameInputField => 'Nomo de monujo:';

  @override
  String get walletNameInputFieldHint => 'Nomo de monujo';

  @override
  String get importSeedTitle => 'Importu semfrazon';

  @override
  String get importSeedDescription => 'Enigu semfrazon de 24 vortoj';

  @override
  String get walletAdvancedButton => 'Altnivela';

  @override
  String get walletAdvancedTitle => 'Altnivelaj agordoj';

  @override
  String get walletEncryptionPasswordInputField =>
      'Ĉifrada pasvorto (se ekzistas):';

  @override
  String get walletEncryptionPasswordInputFieldHint => 'Ĉifrada pasvorto';

  @override
  String get walletEncryptionPasswordRepeatInputField =>
      'Ripetu ĉifradan pasvorton:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'Ripetu monujon ĉifradan pasvorton';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'Importi $fileName';
  }

  @override
  String get saveButton => 'Savi';

  @override
  String get settingsTitle => 'Agordoj';

  @override
  String get nodeUrlInputField => 'Nodo URL:';

  @override
  String get nodeUrlInputFieldHint =>
      'Nodo URL por Veil lightwallet (komenciĝas per http(s)://)';

  @override
  String get basicAuthInputField => 'Baza aŭtentigo de nodo:';

  @override
  String get basicAuthInputFieldHint => 'Malplena por esplorilo nodo';

  @override
  String get explorerUrlInputField => 'Retadreso de esplorilo:';

  @override
  String get explorerUrlInputFieldHint => 'Retadreso de esplorilo';

  @override
  String get explorerTxInputField => 'Adreso de Tx esplorilo:';

  @override
  String get explorerTxInputFieldHint => 'Retadreso de esplorilo transakcia';

  @override
  String get useMinimumUTXOs => 'Uzu minimumajn UTXOojn';

  @override
  String get setupBiometricsButton => 'Agordu biometrikon';

  @override
  String get aboutButton => 'Pri la aplikaĵo';

  @override
  String get biometricsTitle => 'Sekurigu vian monujon';

  @override
  String get biometricsDescription =>
      'Por sekurigi vian monujon ni forte rekomendas agordi biometrikan aŭtentikigon por ĉi tiu programo';

  @override
  String get skipBiometricsButton => 'Saltu (ne rekomendita)';

  @override
  String get walletTitle => 'Monujo';

  @override
  String get notificationsAction => 'Avizoj';

  @override
  String get sendButton => 'Sendu';

  @override
  String get receiveButton => 'Ricevi';

  @override
  String get buyButton => 'Aĉeti';

  @override
  String get transactionsLabel => 'Transakcioj';

  @override
  String get txTypeReceived => 'Ricevis';

  @override
  String get txTypeSent => 'Sendita';

  @override
  String get txTypeUnknown => 'Ne sciata';

  @override
  String get homeNavHome => 'Hejma';

  @override
  String get homeNavExplorer => 'Esplorilo';

  @override
  String get homeNavScanQR => 'Skanu QR';

  @override
  String get homeNavSettings => 'Agordoj';

  @override
  String get homeNavWebsite => 'Retejo';

  @override
  String get passwordsNotMatch => 'Pasvortoj ne kongruas';

  @override
  String get seedWordCantBeEmpty => 'Semvorto ne povas esti malplena';

  @override
  String get seedWordWrong => 'Malĝusta semvorto';

  @override
  String get seedWordNotMatch => 'Semvorto ne kongruas';

  @override
  String get aboutTitle => 'Pri aplikaĵo';

  @override
  String get aboutText => 'Veil wallet - poŝtelefona monujo de kripto de Veil';

  @override
  String get aboutText2 => 'Donaca adreso:';

  @override
  String get copiedText => 'Kopiita en la tondujo';

  @override
  String get authenticateTitle => 'Aŭtentigo';

  @override
  String get authenticateDescription => 'Por aliri monujon, bonvolu aŭtentigi';

  @override
  String get authenticateAction => 'Aŭtentigi ';

  @override
  String get biometricsReason => 'Bonvolu aŭtentikigi por malŝlosi la monujon';

  @override
  String get biometricsSetupReason =>
      'Bonvolu aŭtentikigi por agordi biometrikon';

  @override
  String get biometricsRemoveReason =>
      'Bonvolu aŭtentikigi por forigi biometrikon';

  @override
  String get settingsSaved => 'Agordoj konservitaj';

  @override
  String get removeBiometricsButton => 'Forigi biometrikon';

  @override
  String get loadingAppSemantics => 'Ŝarĝante Veil monujon';

  @override
  String get shareTitle => 'Ricevi monerojn';

  @override
  String get shareDescriptionText => 'Uzu ĉi tiun QR-kodon por ricevi monerojn';

  @override
  String get shareAction => 'Kunhavigu QR-kodon';

  @override
  String get shareSubject => 'Mia QR-kodo por ricevi monerojn de Veil';

  @override
  String shareText(String address) {
    return 'Mia adreso de Veil: $address';
  }

  @override
  String get newTransactionTitle => 'Nova transakcio';

  @override
  String get recipientAddress => 'Adreso de la ricevanto:';

  @override
  String get recipientAddressHint => 'Adreso de la ricevanto';

  @override
  String get sendAmount => 'Kvanto sendenda:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'Disponebla $amount de $overall veil';
  }

  @override
  String get subtractFeeFromAmount => 'Subtrahi krompago de sumo';

  @override
  String get availableText => 'Disponebla:';

  @override
  String get sendCoinsNextAction => 'Sekva';

  @override
  String get makeTxVerifyInvalidAddress => 'Adreso estas malvalida';

  @override
  String get makeTxVerifyAmountCantBeEmpty => 'Kvanto ne povas esti malplena';

  @override
  String get makeTxVerifyAmountMustNotBeNegative =>
      'Kvanto devas esti pli granda ol nulo';

  @override
  String get makeTxVerifyAmountInvalid => 'Kvanto nevalidas';

  @override
  String get makeTxVerifyAmountNotEnough =>
      'Kvanto estas pli granda ol disponebla';

  @override
  String get transactionAlertTitle => 'Transakcio';

  @override
  String get transactionAlertErrorGeneric =>
      'Eraro okazis! Malsukcesis krei transakcion';

  @override
  String get alertOkAction => 'Bone';

  @override
  String get alertCancelAction => 'Nuligi';

  @override
  String get alertSendAction => 'Sendi';

  @override
  String get transactionSummaryRecipient => 'Ricevanto:';

  @override
  String get transactionSummaryAmount => 'Kvanto:';

  @override
  String get transactionSummaryFee => 'Krompago:';

  @override
  String get transactionSummaryTotal => 'Sumo:';

  @override
  String get transactionAlertErrorSendGeneric =>
      'Malsukcesis sendi transakcion! Provu denove';

  @override
  String get transactionAlertSent => 'Transakcio sendita! Tx id:';

  @override
  String get flashlightToolip => 'Ŝaltu la lanterno';

  @override
  String get cameraNoPermissions => 'Apliko ne havas aliron al fotilo';

  @override
  String get scanQRTitle => 'Skanu QR-kodon';

  @override
  String get loadingWalletTitle => 'Ŝarĝante';

  @override
  String get loadingWalletDescription =>
      'Monujo ŝarĝo povas daŭri tempon, bonvolu pacienci';

  @override
  String get loadingAddressTitle => 'Ŝarĝanta adreson';

  @override
  String get loadingAddressDescription =>
      'La ŝarĝado de adreso povas daŭri iom da tempo, bonvolu pacienci';

  @override
  String get walletSettingsTitle => 'Monujo-agordoj';

  @override
  String get deleteWalletAction => 'Forigi monujon';

  @override
  String get deleteWalletConfirmationTitle => 'Forigi monujon';

  @override
  String get deleteWalletConfirmation =>
      'Ĉu vi certas, ke vi volas forigi la monujon?';

  @override
  String get yesAction => 'Jes';

  @override
  String get noAction => 'Ne';

  @override
  String get nodeFailedTitle => 'Eraro';

  @override
  String get nodeFailedDescription =>
      'Malsukcesis konekti al nodo, bonvolu provi denove';

  @override
  String get nodeFailedAction => 'Rekonekti';

  @override
  String get nodeFailedAlertTitle => 'Eraro';

  @override
  String get nodeFailedAlertDescription =>
      'Malsukcesis konekti al nodo, bonvolu provi denove';

  @override
  String get transactionsListEmpty =>
      'Transakcioj ne trovitaj aŭ ankoraŭ ne ŝarĝitaj';

  @override
  String get syncStatusSyncedSemantics =>
      'La adreso estas sinkronigita kun la nodo';

  @override
  String get syncStatusScanningFailedSemantics =>
      'Malsukcesis sinkronigi adreson';

  @override
  String get syncStatusScanningSemantics => 'La nodo skanas vian adreson';

  @override
  String get localeSelectionTitle => 'Elektu lingvon';

  @override
  String get nodeSelectionTitle => 'Disponeblaj nodoj';

  @override
  String get darkMode => 'Malhelan temon';

  @override
  String get discordInfo => 'Oficiala Discord:';

  @override
  String get discordFaucetInfo =>
      '* Vi povas akiri Veil per la krano havebla sur la oficiala Discord';

  @override
  String get legalInfo => 'Juraj informoj';

  @override
  String get legalTitle => 'Juraj informoj';

  @override
  String get createAddress => 'Krei adreson';

  @override
  String get addressCreated => 'Adreso estas kreita';

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
  String get addressBookRemoveSemantics => 'Remove address from address book';

  @override
  String get addressBookEditSemantics => 'Edit address from address book';

  @override
  String get addressBookNewAddress => 'New address';

  @override
  String get addressBookNewAddressLabel => 'Address label';

  @override
  String get addressBookNewAddressLabelHint => 'Address label';

  @override
  String get addressBookNewAddressValue => 'Address';

  @override
  String get addressBookNewAddressValueHint => 'Address';

  @override
  String get addressBookNewAddressCancelButton => 'Cancel';

  @override
  String get addressBookNewAddressSaveButton => 'Save';

  @override
  String get addressBookNewAddressSavedNotification =>
      'Address added to address book';

  @override
  String get noAddressBookAddresses => 'Addresses not found';

  @override
  String get addressBookDeleteAddressConfirmationTitle => 'Delete address';

  @override
  String get addressBookDeleteAddressConfirmation =>
      'Are you sure you want to delete address from address book?';

  @override
  String get addressBookAddressDeleted => 'Address deleted from address book';

  @override
  String get addressBookEditAddress => 'Edit address';

  @override
  String get addressBookNoLabel => 'Default';

  @override
  String get resetExplorerIconSemantics => 'Reset explorer address';

  @override
  String get resetExplorerTxesIconSemantics => 'Reset explorer tx address';

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
