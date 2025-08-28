// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Veil wallet';

  @override
  String get welcomeTitle => 'Welcome to Veil!';

  @override
  String get welcomeDescription => 'Import existing wallet or create new';

  @override
  String get createWallet => 'Create';

  @override
  String get importWallet => 'Import';

  @override
  String get settingsButton => 'Settings';

  @override
  String get saveSeedPhraseTitle => 'Save seed phrase';

  @override
  String get saveSeedPhraseDescription => 'Save new wallet seed phrase:';

  @override
  String get nextButton => 'Next';

  @override
  String get verifySeedPhraseTitle => 'Verify seed phrase';

  @override
  String get verifySeedPhraseDescription => 'Verify 24 words seed:';

  @override
  String get createWalletButton => 'Create wallet';

  @override
  String get walletNameInputField => 'Wallet name:';

  @override
  String get walletNameInputFieldHint => 'Wallet name';

  @override
  String get importSeedTitle => 'Import seed phrase';

  @override
  String get importSeedDescription => 'Enter 24 words seed phrase:';

  @override
  String get walletAdvancedButton => 'Advanced';

  @override
  String get walletAdvancedTitle => 'Advanced settings';

  @override
  String get walletEncryptionPasswordInputField =>
      'Encryption password (if exists):';

  @override
  String get walletEncryptionPasswordInputFieldHint =>
      'Wallet encryption password';

  @override
  String get walletEncryptionPasswordRepeatInputField =>
      'Repeat encryption password:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'Repeat wallet encryption password';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'Import $fileName';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get nodeUrlInputField => 'Node url:';

  @override
  String get nodeUrlInputFieldHint =>
      'Veil lightwallet node url (starts with http(s)://)';

  @override
  String get basicAuthInputField => 'Node basic auth:';

  @override
  String get basicAuthInputFieldHint => 'Empty for explorer\'s node';

  @override
  String get explorerUrlInputField => 'Explorer URL:';

  @override
  String get explorerUrlInputFieldHint => 'Explorer URL';

  @override
  String get explorerTxInputField => 'Tx explorer url:';

  @override
  String get explorerTxInputFieldHint => 'Transactions explorer URL';

  @override
  String get useMinimumUTXOs => 'Use minimum UTXOs';

  @override
  String get setupBiometricsButton => 'Set up biometrics';

  @override
  String get aboutButton => 'About app';

  @override
  String get biometricsTitle => 'Secure your wallet';

  @override
  String get biometricsDescription =>
      'To secure your wallet we strongly recommend to setup biometrics authentication for this app';

  @override
  String get skipBiometricsButton => 'Skip (not recommended)';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get notificationsAction => 'Notifications';

  @override
  String get sendButton => 'Send';

  @override
  String get receiveButton => 'Receive';

  @override
  String get buyButton => 'Buy';

  @override
  String get transactionsLabel => 'Transactions';

  @override
  String get txTypeReceived => 'Received';

  @override
  String get txTypeSent => 'Sent';

  @override
  String get txTypeUnknown => 'Unknown';

  @override
  String get homeNavHome => 'Home';

  @override
  String get homeNavExplorer => 'Explorer';

  @override
  String get homeNavScanQR => 'Scan QR';

  @override
  String get homeNavSettings => 'Settings';

  @override
  String get homeNavWebsite => 'Website';

  @override
  String get passwordsNotMatch => 'Passwords don\'t match';

  @override
  String get seedWordCantBeEmpty => 'Seed word can\'t be empty';

  @override
  String get seedWordWrong => 'Wrong seed word';

  @override
  String get seedWordNotMatch => 'Seed word doesn\'t match';

  @override
  String get aboutTitle => 'About app';

  @override
  String get aboutText =>
      'Veil wallet - mobile Veil cryptocurrency wallet.\nSource code is available here:';

  @override
  String get aboutText2 => 'Donations address:';

  @override
  String get copiedText => 'Copied to clipboard';

  @override
  String get authenticateTitle => 'Authentication';

  @override
  String get authenticateDescription => 'To access wallet, please authenticate';

  @override
  String get authenticateAction => 'Authenticate';

  @override
  String get biometricsReason => 'Please authenticate to unlock wallet';

  @override
  String get biometricsSetupReason => 'Please authenticate to setup biometrics';

  @override
  String get biometricsRemoveReason =>
      'Please authenticate to remove biometrics';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get removeBiometricsButton => 'Remove biometrics';

  @override
  String get loadingAppSemantics => 'Loading Veil wallet';

  @override
  String get shareTitle => 'Receive coins';

  @override
  String get shareDescriptionText => 'Use this QR code to receive coins';

  @override
  String get shareAction => 'Share QR code';

  @override
  String get shareSubject => 'My QR code to receive Veil coins';

  @override
  String shareText(String address) {
    return 'My Veil address: $address';
  }

  @override
  String get newTransactionTitle => 'New transaction';

  @override
  String get recipientAddress => 'Recipient address:';

  @override
  String get recipientAddressHint => 'Recipient address';

  @override
  String get sendAmount => 'Send amount:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'Available $amount of $overall veil';
  }

  @override
  String get subtractFeeFromAmount => 'Subtract fee from amount';

  @override
  String get availableText => 'Available:';

  @override
  String get sendCoinsNextAction => 'Next';

  @override
  String get makeTxVerifyInvalidAddress => 'Address is invalid';

  @override
  String get makeTxVerifyAmountCantBeEmpty => 'Amount can\'t be empty';

  @override
  String get makeTxVerifyAmountMustNotBeNegative =>
      'Amount must be greater than zero';

  @override
  String get makeTxVerifyAmountInvalid => 'Amount is invalid';

  @override
  String get makeTxVerifyAmountNotEnough => 'Amount is greater than available';

  @override
  String get transactionAlertTitle => 'Transaction';

  @override
  String get transactionAlertErrorGeneric =>
      'Error occured! Can\'t create transaction.';

  @override
  String get alertOkAction => 'OK';

  @override
  String get alertCancelAction => 'Cancel';

  @override
  String get alertSendAction => 'Send';

  @override
  String get transactionSummaryRecipient => 'Recipient:';

  @override
  String get transactionSummaryAmount => 'Amount:';

  @override
  String get transactionSummaryFee => 'Fee:';

  @override
  String get transactionSummaryTotal => 'Total:';

  @override
  String get transactionAlertErrorSendGeneric =>
      'Failed to send transaction! Please try again';

  @override
  String get transactionAlertSent => 'Transaction sent! Tx id:';

  @override
  String get flashlightToolip => 'Toggle flashlight';

  @override
  String get cameraNoPermissions => 'Application has no access to camera';

  @override
  String get scanQRTitle => 'Scan QR code';

  @override
  String get loadingWalletTitle => 'Loading';

  @override
  String get loadingWalletDescription =>
      'Wallet loading may take a while, please be patient';

  @override
  String get loadingAddressTitle => 'Loading address';

  @override
  String get loadingAddressDescription =>
      'Address loading may take a while, please be patient';

  @override
  String get walletSettingsTitle => 'Wallet settings';

  @override
  String get deleteWalletAction => 'Delete wallet';

  @override
  String get deleteWalletConfirmationTitle => 'Delete wallet';

  @override
  String get deleteWalletConfirmation =>
      'Are you sure you want to delete the wallet?';

  @override
  String get yesAction => 'Yes';

  @override
  String get noAction => 'No';

  @override
  String get nodeFailedTitle => 'Error';

  @override
  String get nodeFailedDescription =>
      'Failed to connect to node, please try again';

  @override
  String get nodeFailedAction => 'Reconnect';

  @override
  String get nodeFailedAlertTitle => 'Error';

  @override
  String get nodeFailedAlertDescription =>
      'Failed to connect to node, please try again';

  @override
  String get transactionsListEmpty =>
      'Transactions not found or not yet loaded';

  @override
  String get syncStatusSyncedSemantics => 'Address is synced with node';

  @override
  String get syncStatusScanningFailedSemantics => 'Address sync failed';

  @override
  String get syncStatusScanningSemantics => 'Node is now scanning your address';

  @override
  String get localeSelectionTitle => 'Select language';

  @override
  String get nodeSelectionTitle => 'Available nodes';

  @override
  String get darkMode => 'Use dark theme';

  @override
  String get discordInfo => 'Official discord:';

  @override
  String get discordFaucetInfo =>
      '* You can get some coins via faucet, available in official discord';

  @override
  String get legalInfo => 'Legal info';

  @override
  String get legalTitle => 'Legal info';

  @override
  String get createAddress => 'Create address';

  @override
  String get addressCreated => 'Address created';

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
