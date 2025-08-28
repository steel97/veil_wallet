import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_eo.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('eo'),
    Locale('es'),
    Locale('ja'),
    Locale('lt'),
    Locale('ru')
  ];

  /// The title of application
  ///
  /// In en, this message translates to:
  /// **'Veil wallet'**
  String get title;

  /// The title of welcome screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Veil!'**
  String get welcomeTitle;

  /// Title description of welcome screen
  ///
  /// In en, this message translates to:
  /// **'Import existing wallet or create new'**
  String get welcomeDescription;

  /// Text on create wallet button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createWallet;

  /// Text on import wallet button
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importWallet;

  /// Accessibility label for settings icon (appbar/navbar)
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsButton;

  /// Save seed phrase screen title
  ///
  /// In en, this message translates to:
  /// **'Save seed phrase'**
  String get saveSeedPhraseTitle;

  /// Save seed phrase description
  ///
  /// In en, this message translates to:
  /// **'Save new wallet seed phrase:'**
  String get saveSeedPhraseDescription;

  /// "Next" text for buttons
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// Verify seed phrase screen title
  ///
  /// In en, this message translates to:
  /// **'Verify seed phrase'**
  String get verifySeedPhraseTitle;

  /// Verify seed phrase description
  ///
  /// In en, this message translates to:
  /// **'Verify 24 words seed:'**
  String get verifySeedPhraseDescription;

  /// Create wallet button (verify seed screen)
  ///
  /// In en, this message translates to:
  /// **'Create wallet'**
  String get createWalletButton;

  /// Wallet name input field (import/create wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Wallet name:'**
  String get walletNameInputField;

  /// Wallet name input field hint (import/create wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Wallet name'**
  String get walletNameInputFieldHint;

  /// Import seed phrase title
  ///
  /// In en, this message translates to:
  /// **'Import seed phrase'**
  String get importSeedTitle;

  /// Import seed description
  ///
  /// In en, this message translates to:
  /// **'Enter 24 words seed phrase:'**
  String get importSeedDescription;

  /// Advanced button (import screen)
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get walletAdvancedButton;

  /// Advanced screen title
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get walletAdvancedTitle;

  /// Encryption password input field (advanced import/new wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Encryption password (if exists):'**
  String get walletEncryptionPasswordInputField;

  /// Encryption password input field hint (advanced import/new wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Wallet encryption password'**
  String get walletEncryptionPasswordInputFieldHint;

  /// Encryption password repeat input field (advanced import/new wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Repeat encryption password:'**
  String get walletEncryptionPasswordRepeatInputField;

  /// Encryption password repeat input field hint (advanced import/new wallet screen)
  ///
  /// In en, this message translates to:
  /// **'Repeat wallet encryption password'**
  String get walletEncryptionPasswordRepeatInputFieldHint;

  /// Import "transactions.json" text (under advanced import/create wallet screens)
  ///
  /// In en, this message translates to:
  /// **'Import {fileName}'**
  String walletImportTransactionsData(String fileName);

  /// Save button text (under advanced/create wallet screens)
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Node url input field (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Node url:'**
  String get nodeUrlInputField;

  /// Node url input field hint (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Veil lightwallet node url (starts with http(s)://)'**
  String get nodeUrlInputFieldHint;

  /// Node basic auth input field (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Node basic auth:'**
  String get basicAuthInputField;

  /// Node basic auth input field hint (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Empty for explorer\'s node'**
  String get basicAuthInputFieldHint;

  /// Explorer url input field (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Explorer URL:'**
  String get explorerUrlInputField;

  /// Explorer url input field hint (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Explorer URL'**
  String get explorerUrlInputFieldHint;

  /// Explorer tx input field (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Tx explorer url:'**
  String get explorerTxInputField;

  /// Explorer tx input field hint (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Transactions explorer URL'**
  String get explorerTxInputFieldHint;

  /// Use minimum UTXOs checkbox (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Use minimum UTXOs'**
  String get useMinimumUTXOs;

  /// Setup biometrics button (settings screen)
  ///
  /// In en, this message translates to:
  /// **'Set up biometrics'**
  String get setupBiometricsButton;

  /// About button (settings screen)
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get aboutButton;

  /// Secure your wallet title (biometrics screen)
  ///
  /// In en, this message translates to:
  /// **'Secure your wallet'**
  String get biometricsTitle;

  /// Secure your wallet description (biometrics screen)
  ///
  /// In en, this message translates to:
  /// **'To secure your wallet we strongly recommend to setup biometrics authentication for this app'**
  String get biometricsDescription;

  /// Skip button (biometrics screen)
  ///
  /// In en, this message translates to:
  /// **'Skip (not recommended)'**
  String get skipBiometricsButton;

  /// Home screen title string
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTitle;

  /// Notifications label for accessibility
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsAction;

  /// Home screen send button
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// Home screen receive button
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receiveButton;

  /// Home screen buy button
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyButton;

  /// Home screen transactions label
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsLabel;

  /// Transaction card received text
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get txTypeReceived;

  /// Transaction card sent text
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get txTypeSent;

  /// Transaction card unknown text
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get txTypeUnknown;

  /// Bottom nav bar home button label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNavHome;

  /// Bottom nav bar explorer button label
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get homeNavExplorer;

  /// Bottom nav bar scan qr button label
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get homeNavScanQR;

  /// Bottom nav bar settings button label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeNavSettings;

  /// Bottom nav bar website button label
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get homeNavWebsite;

  /// Advanced import/create settings password validation error
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsNotMatch;

  /// Mnemonic validation (empty)
  ///
  /// In en, this message translates to:
  /// **'Seed word can\'t be empty'**
  String get seedWordCantBeEmpty;

  /// Mnemonic validation (word not in vocablurary)
  ///
  /// In en, this message translates to:
  /// **'Wrong seed word'**
  String get seedWordWrong;

  /// Mnemonic validation (word doesn't match generated word)
  ///
  /// In en, this message translates to:
  /// **'Seed word doesn\'t match'**
  String get seedWordNotMatch;

  /// About screen title
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get aboutTitle;

  /// About screen description #1
  ///
  /// In en, this message translates to:
  /// **'Veil wallet - mobile Veil cryptocurrency wallet.\nSource code is available here:'**
  String get aboutText;

  /// About screen description #2
  ///
  /// In en, this message translates to:
  /// **'Donations address:'**
  String get aboutText2;

  /// Notification when copy action used
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedText;

  /// Authentication title
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authenticateTitle;

  /// Authentication description
  ///
  /// In en, this message translates to:
  /// **'To access wallet, please authenticate'**
  String get authenticateDescription;

  /// Authenticate action
  ///
  /// In en, this message translates to:
  /// **'Authenticate'**
  String get authenticateAction;

  /// Reason to use biometrics
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to unlock wallet'**
  String get biometricsReason;

  /// Setup biometrics description
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to setup biometrics'**
  String get biometricsSetupReason;

  /// Remove biometrics description
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to remove biometrics'**
  String get biometricsRemoveReason;

  /// Settings saved notification
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// Settings screen remove biometrics action
  ///
  /// In en, this message translates to:
  /// **'Remove biometrics'**
  String get removeBiometricsButton;

  /// Accesibility label for loader screen
  ///
  /// In en, this message translates to:
  /// **'Loading Veil wallet'**
  String get loadingAppSemantics;

  /// Title text on receive coins screen
  ///
  /// In en, this message translates to:
  /// **'Receive coins'**
  String get shareTitle;

  /// Description text on receive coins screen
  ///
  /// In en, this message translates to:
  /// **'Use this QR code to receive coins'**
  String get shareDescriptionText;

  /// Share action on receive coins screen
  ///
  /// In en, this message translates to:
  /// **'Share QR code'**
  String get shareAction;

  /// Share subject (used for e-mails)
  ///
  /// In en, this message translates to:
  /// **'My QR code to receive Veil coins'**
  String get shareSubject;

  /// Share default text
  ///
  /// In en, this message translates to:
  /// **'My Veil address: {address}'**
  String shareText(String address);

  /// Title text on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'New transaction'**
  String get newTransactionTitle;

  /// Recipient address text on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Recipient address:'**
  String get recipientAddress;

  /// Recipient address hint on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Recipient address'**
  String get recipientAddressHint;

  /// Send amount text on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Send amount:'**
  String get sendAmount;

  /// Send amount hint on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Available {amount} of {overall} veil'**
  String sendAmountHint(String amount, String overall);

  /// Subtract fee from amount text on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Subtract fee from amount'**
  String get subtractFeeFromAmount;

  /// Available coins text on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Available:'**
  String get availableText;

  /// Send coins next action on new transaction screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get sendCoinsNextAction;

  /// Make tx verification address
  ///
  /// In en, this message translates to:
  /// **'Address is invalid'**
  String get makeTxVerifyInvalidAddress;

  /// Make tx verification amount empty
  ///
  /// In en, this message translates to:
  /// **'Amount can\'t be empty'**
  String get makeTxVerifyAmountCantBeEmpty;

  /// Make tx verification amount
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero'**
  String get makeTxVerifyAmountMustNotBeNegative;

  /// Make tx verification amount
  ///
  /// In en, this message translates to:
  /// **'Amount is invalid'**
  String get makeTxVerifyAmountInvalid;

  /// Make tx verification amount greater than available
  ///
  /// In en, this message translates to:
  /// **'Amount is greater than available'**
  String get makeTxVerifyAmountNotEnough;

  /// Make tx transaction info or error alert title
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transactionAlertTitle;

  /// Make tx transaction info or error alert generic error
  ///
  /// In en, this message translates to:
  /// **'Error occured! Can\'t create transaction.'**
  String get transactionAlertErrorGeneric;

  /// Alert ok action
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get alertOkAction;

  /// Alert cancel action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alertCancelAction;

  /// Alert send action
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get alertSendAction;

  /// Transaction summary recipient label
  ///
  /// In en, this message translates to:
  /// **'Recipient:'**
  String get transactionSummaryRecipient;

  /// Transaction summary amount label
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get transactionSummaryAmount;

  /// Transaction summary fee label
  ///
  /// In en, this message translates to:
  /// **'Fee:'**
  String get transactionSummaryFee;

  /// Transaction summary total label
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get transactionSummaryTotal;

  /// Failed to send transaction alert
  ///
  /// In en, this message translates to:
  /// **'Failed to send transaction! Please try again'**
  String get transactionAlertErrorSendGeneric;

  /// Transaction successfully sent alert
  ///
  /// In en, this message translates to:
  /// **'Transaction sent! Tx id:'**
  String get transactionAlertSent;

  /// QR scanner flashlight
  ///
  /// In en, this message translates to:
  /// **'Toggle flashlight'**
  String get flashlightToolip;

  /// QR scanner camera no permissions error message
  ///
  /// In en, this message translates to:
  /// **'Application has no access to camera'**
  String get cameraNoPermissions;

  /// QR scanner screen title
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQRTitle;

  /// Loading wallet title
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingWalletTitle;

  /// Loading wallet description
  ///
  /// In en, this message translates to:
  /// **'Wallet loading may take a while, please be patient'**
  String get loadingWalletDescription;

  /// Loading address title
  ///
  /// In en, this message translates to:
  /// **'Loading address'**
  String get loadingAddressTitle;

  /// Loading address description
  ///
  /// In en, this message translates to:
  /// **'Address loading may take a while, please be patient'**
  String get loadingAddressDescription;

  /// Wallet settings screen title
  ///
  /// In en, this message translates to:
  /// **'Wallet settings'**
  String get walletSettingsTitle;

  /// Delete wallet action text (wallet settings)
  ///
  /// In en, this message translates to:
  /// **'Delete wallet'**
  String get deleteWalletAction;

  /// Delete wallet title
  ///
  /// In en, this message translates to:
  /// **'Delete wallet'**
  String get deleteWalletConfirmationTitle;

  /// Delete wallet description
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the wallet?'**
  String get deleteWalletConfirmation;

  /// Yes action text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesAction;

  /// No action text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noAction;

  /// Node failed screen title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get nodeFailedTitle;

  /// Node failed screen description
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to node, please try again'**
  String get nodeFailedDescription;

  /// Node failed screen action
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get nodeFailedAction;

  /// Node failed alert title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get nodeFailedAlertTitle;

  /// Node failed alert description
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to node, please try again'**
  String get nodeFailedAlertDescription;

  /// Transactions list empty text on home page
  ///
  /// In en, this message translates to:
  /// **'Transactions not found or not yet loaded'**
  String get transactionsListEmpty;

  /// Lightwallet address sync semantics when address sucessfully synced
  ///
  /// In en, this message translates to:
  /// **'Address is synced with node'**
  String get syncStatusSyncedSemantics;

  /// Lightwallet address sync semantics when error occured
  ///
  /// In en, this message translates to:
  /// **'Address sync failed'**
  String get syncStatusScanningFailedSemantics;

  /// Lightwallet address sync semantics when scanning in progress
  ///
  /// In en, this message translates to:
  /// **'Node is now scanning your address'**
  String get syncStatusScanningSemantics;

  /// Locale selection dialog title
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get localeSelectionTitle;

  /// Node selection dialog title
  ///
  /// In en, this message translates to:
  /// **'Available nodes'**
  String get nodeSelectionTitle;

  /// Dark theme setting
  ///
  /// In en, this message translates to:
  /// **'Use dark theme'**
  String get darkMode;

  /// About screen label, discord link
  ///
  /// In en, this message translates to:
  /// **'Official discord:'**
  String get discordInfo;

  /// Info about faucet
  ///
  /// In en, this message translates to:
  /// **'* You can get some coins via faucet, available in official discord'**
  String get discordFaucetInfo;

  /// Legal info button in about screen
  ///
  /// In en, this message translates to:
  /// **'Legal info'**
  String get legalInfo;

  /// Legal info screen title
  ///
  /// In en, this message translates to:
  /// **'Legal info'**
  String get legalTitle;

  /// Create address button inside address selection popup
  ///
  /// In en, this message translates to:
  /// **'Create address'**
  String get createAddress;

  /// Address created snack bar
  ///
  /// In en, this message translates to:
  /// **'Address created'**
  String get addressCreated;

  /// Tooltip which describe that QR scanner is not available on platform (desktop)
  ///
  /// In en, this message translates to:
  /// **'QR scanner is unavailable on desktop'**
  String get homeNavScanQRUnavailable;

  /// Recent label on make transaction screen
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get sendHistoryRecent;

  /// Recent section no sent transactions label
  ///
  /// In en, this message translates to:
  /// **'No sent transactions found'**
  String get noSentTransactions;

  /// Make tx history loading semantics
  ///
  /// In en, this message translates to:
  /// **'History loading'**
  String get historyLoadingSemantics;

  /// Recent section history deleted notification
  ///
  /// In en, this message translates to:
  /// **'History deleted'**
  String get historyDeleted;

  /// Recent section history deleted confirmation alert dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete history'**
  String get historyDeleteConfirmationTitle;

  /// Recent section history deleted confirmation alert dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete history?'**
  String get historyDeleteConfirmation;

  /// Settings view delete all data button
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllData;

  /// Settings view delete all data dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllDataTitle;

  /// Settings view delete all data dialog confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all data (all wallets, settings, history)?'**
  String get deleteAllDataConfirmation;

  /// Settings view deleted all data notification
  ///
  /// In en, this message translates to:
  /// **'All data erased'**
  String get deleteAllDataNotification;

  /// Address book view title
  ///
  /// In en, this message translates to:
  /// **'Address book'**
  String get addressBookTitle;

  /// Address book search input label
  ///
  /// In en, this message translates to:
  /// **'Search address'**
  String get addressBookSearchLabel;

  /// Address book search input hint
  ///
  /// In en, this message translates to:
  /// **'Enter address or label'**
  String get addressBookSearchHint;

  /// Address book saved addresses label
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get addressBookSavedAddresses;

  /// Address book loading circle semantics
  ///
  /// In en, this message translates to:
  /// **'Loading address book'**
  String get addressBookLoadingSemantics;

  /// Clear address book dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear address book'**
  String get addressBookClearConfirmationTitle;

  /// Clear address book dialog text
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear address book?'**
  String get addressBookClearConfirmation;

  /// Address book cleared notifications
  ///
  /// In en, this message translates to:
  /// **'Address book cleared'**
  String get addressBookCleared;

  /// Address book remove address semantics
  ///
  /// In en, this message translates to:
  /// **'Remove address from address book'**
  String get addressBookRemoveSemantics;

  /// Address book edit address semantics
  ///
  /// In en, this message translates to:
  /// **'Edit address from address book'**
  String get addressBookEditSemantics;

  /// Add new address to address book dialog title
  ///
  /// In en, this message translates to:
  /// **'New address'**
  String get addressBookNewAddress;

  /// Add new address to address book dialog address label
  ///
  /// In en, this message translates to:
  /// **'Address label'**
  String get addressBookNewAddressLabel;

  /// Add new address to address book dialog address label hint
  ///
  /// In en, this message translates to:
  /// **'Address label'**
  String get addressBookNewAddressLabelHint;

  /// Add new address to address book dialog address
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressBookNewAddressValue;

  /// Add new address to address book dialog address hint
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressBookNewAddressValueHint;

  /// Add new address to address book dialog cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get addressBookNewAddressCancelButton;

  /// Add new address to address book dialog save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get addressBookNewAddressSaveButton;

  /// Address added to address book notification
  ///
  /// In en, this message translates to:
  /// **'Address added to address book'**
  String get addressBookNewAddressSavedNotification;

  /// Address book is empty label
  ///
  /// In en, this message translates to:
  /// **'Addresses not found'**
  String get noAddressBookAddresses;

  /// Address book address delete dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete address'**
  String get addressBookDeleteAddressConfirmationTitle;

  /// Address book address delete dialog text
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete address from address book?'**
  String get addressBookDeleteAddressConfirmation;

  /// Address book address deleted notification
  ///
  /// In en, this message translates to:
  /// **'Address deleted from address book'**
  String get addressBookAddressDeleted;

  /// Address book edit address title
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get addressBookEditAddress;

  /// Address label value if not set by user
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get addressBookNoLabel;

  /// Settings explorer input field reset button semantics
  ///
  /// In en, this message translates to:
  /// **'Reset explorer address'**
  String get resetExplorerIconSemantics;

  /// Settings tx explorer input field reset button semantics
  ///
  /// In en, this message translates to:
  /// **'Reset explorer tx address'**
  String get resetExplorerTxesIconSemantics;

  /// Label for custom conversion rate input field
  ///
  /// In en, this message translates to:
  /// **'Custom conversion rate (USD):'**
  String get conversionRateInputField;

  /// Conversion rate input field hint
  ///
  /// In en, this message translates to:
  /// **'Veil/USD conversion rate (ex. 0.006)'**
  String get conversionRateInputFieldHint;

  /// Reset conversion rate to default value
  ///
  /// In en, this message translates to:
  /// **'Reset conversion rate default value'**
  String get resetConversionRateSemantics;

  /// Label for conversion API url
  ///
  /// In en, this message translates to:
  /// **'Conversion API url:'**
  String get conversionApiInputField;

  /// Conversion api input field hint
  ///
  /// In en, this message translates to:
  /// **'Should start with http:// or https://'**
  String get conversionApiInputFieldHint;

  /// Reset conversion API url to default value
  ///
  /// In en, this message translates to:
  /// **'Reset conversion API url to default value'**
  String get resetConversionApiSemantics;

  /// Use custom conversion rate toggle
  ///
  /// In en, this message translates to:
  /// **'Use custom conversion rate'**
  String get useCustomConversionRate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'eo',
        'es',
        'ja',
        'lt',
        'ru'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'eo':
      return AppLocalizationsEo();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'lt':
      return AppLocalizationsLt();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
