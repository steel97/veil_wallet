// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get title => 'Veil кошелек';

  @override
  String get welcomeTitle => 'Добро пожаловать!';

  @override
  String get welcomeDescription => 'Импортируйте или создайте кошелек';

  @override
  String get createWallet => 'Создать';

  @override
  String get importWallet => 'Импорт';

  @override
  String get settingsButton => 'Настройки';

  @override
  String get saveSeedPhraseTitle => 'Новый кошелек';

  @override
  String get saveSeedPhraseDescription =>
      'Сохраните сид-фразу нового кошелька:';

  @override
  String get nextButton => 'Далее';

  @override
  String get verifySeedPhraseTitle => 'Проверка сид-фразы';

  @override
  String get verifySeedPhraseDescription => 'Проверка сид фразы из 24 слов:';

  @override
  String get createWalletButton => 'Создать кошелек';

  @override
  String get walletNameInputField => 'Имя кошелька:';

  @override
  String get walletNameInputFieldHint => 'Имя кошелька';

  @override
  String get importSeedTitle => 'Импорт сид-фразы';

  @override
  String get importSeedDescription => 'Введите сид-фразу:';

  @override
  String get walletAdvancedButton => 'Доп. настройки';

  @override
  String get walletAdvancedTitle => 'Доп. настройки';

  @override
  String get walletEncryptionPasswordInputField =>
      'Пароль шифрования (если существует):';

  @override
  String get walletEncryptionPasswordInputFieldHint => 'Пароль шифрования';

  @override
  String get walletEncryptionPasswordRepeatInputField =>
      'Повторите пароль шифрования:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'Повторите пароль шифрования';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'Импорт $fileName';
  }

  @override
  String get saveButton => 'Сохранить';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get nodeUrlInputField => 'Адрес ноды:';

  @override
  String get nodeUrlInputFieldHint =>
      'Адрес lightwallet Veil ноды (начинается с http(s)://)';

  @override
  String get basicAuthInputField => 'Basic авторизация ноды:';

  @override
  String get basicAuthInputFieldHint => 'Пусто для ноды обозревателя';

  @override
  String get explorerUrlInputField => 'Адрес обозревателя:';

  @override
  String get explorerUrlInputFieldHint => 'Адрес обозревателя';

  @override
  String get explorerTxInputField => 'Адрес обозревателя (транзакции):';

  @override
  String get explorerTxInputFieldHint => 'Адрес обозревателя';

  @override
  String get useMinimumUTXOs => 'Использовать минимум UTXO';

  @override
  String get setupBiometricsButton => 'Настроить биометрику';

  @override
  String get aboutButton => 'О приложении';

  @override
  String get biometricsTitle => 'Безопасность кошелька';

  @override
  String get biometricsDescription =>
      'Чтобы защитить кошелек, мы настоятельно рекомендуем настроить биометрическую аутентификацию';

  @override
  String get skipBiometricsButton => 'Пропустить (не рекомендуется)';

  @override
  String get walletTitle => 'Кошелек';

  @override
  String get notificationsAction => 'Уведомления';

  @override
  String get sendButton => 'Отправить';

  @override
  String get receiveButton => 'Получить';

  @override
  String get buyButton => 'Купить';

  @override
  String get transactionsLabel => 'Транзакции';

  @override
  String get txTypeReceived => 'Получено';

  @override
  String get txTypeSent => 'Отправлено';

  @override
  String get txTypeUnknown => 'Не известно';

  @override
  String get homeNavHome => 'Кошелек';

  @override
  String get homeNavExplorer => 'Обозреватель';

  @override
  String get homeNavScanQR => 'Скан. QR';

  @override
  String get homeNavSettings => 'Настройки';

  @override
  String get homeNavWebsite => 'Веб-сайт';

  @override
  String get passwordsNotMatch => 'Пароли не совпадают';

  @override
  String get seedWordCantBeEmpty => 'Слово не может быть пустым';

  @override
  String get seedWordWrong => 'Не верное слово';

  @override
  String get seedWordNotMatch => 'Слово не совпадает';

  @override
  String get aboutTitle => 'О приложении';

  @override
  String get aboutText =>
      'Veil wallet - мобильный кошелек для криптовалюты Veil.\nИсходный код доступен здесь:';

  @override
  String get aboutText2 => 'Адрес для пожертвований:';

  @override
  String get copiedText => 'Скопировано';

  @override
  String get authenticateTitle => 'Авторизация';

  @override
  String get authenticateDescription =>
      'Чтобы разблокировать кошелек, пожалуйста авторизуйтесь';

  @override
  String get authenticateAction => 'Авторизоваться';

  @override
  String get biometricsReason =>
      'Пожалуйста авторизуйтесь для разблокировки кошелька';

  @override
  String get biometricsSetupReason =>
      'Пожалуйста авторизуйтесь для настройки биометрики';

  @override
  String get biometricsRemoveReason =>
      'Пожалуйста авторизуйтесь для удаления биометрики';

  @override
  String get settingsSaved => 'Настройки сохранены';

  @override
  String get removeBiometricsButton => 'Удалить биометрику';

  @override
  String get loadingAppSemantics => 'Загрузка кошелька Veil';

  @override
  String get shareTitle => 'Получить veil';

  @override
  String get shareDescriptionText =>
      'Используйте этот QR код для получения монет';

  @override
  String get shareAction => 'Поделиться QR кодом';

  @override
  String get shareSubject => 'Мой QR код для получения монеты Veil';

  @override
  String shareText(String address) {
    return 'Мой Veil адрес: $address';
  }

  @override
  String get newTransactionTitle => 'Новая транзакция';

  @override
  String get recipientAddress => 'Адрес получателя:';

  @override
  String get recipientAddressHint => 'Адрес получателя';

  @override
  String get sendAmount => 'Сумма к отправке:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'Доступно $amount из $overall veil';
  }

  @override
  String get subtractFeeFromAmount => 'Вычесть комиссию из суммы';

  @override
  String get availableText => 'Доступно:';

  @override
  String get sendCoinsNextAction => 'Далее';

  @override
  String get makeTxVerifyInvalidAddress => 'Адрес не верен';

  @override
  String get makeTxVerifyAmountCantBeEmpty => 'Сумма не может быть пустой';

  @override
  String get makeTxVerifyAmountMustNotBeNegative =>
      'Сумма не может быть меньше или равной нулю';

  @override
  String get makeTxVerifyAmountInvalid => 'Сумма введена неверно';

  @override
  String get makeTxVerifyAmountNotEnough => 'Сумма превышает доступную';

  @override
  String get transactionAlertTitle => 'Транзакция';

  @override
  String get transactionAlertErrorGeneric =>
      'Произошла ошибка! Не удалось создать транзакцию';

  @override
  String get alertOkAction => 'OK';

  @override
  String get alertCancelAction => 'Отменить';

  @override
  String get alertSendAction => 'Отправить';

  @override
  String get transactionSummaryRecipient => 'Получатель:';

  @override
  String get transactionSummaryAmount => 'К отправке:';

  @override
  String get transactionSummaryFee => 'Комиссия:';

  @override
  String get transactionSummaryTotal => 'Всего:';

  @override
  String get transactionAlertErrorSendGeneric =>
      'Не удалось отправить транзакцию! Попробуйте ещё раз';

  @override
  String get transactionAlertSent => 'Транзакция отправлена! Tx id:';

  @override
  String get flashlightToolip => 'Фонарик';

  @override
  String get cameraNoPermissions => 'У приложения нет доступа к камере';

  @override
  String get scanQRTitle => 'Сканировать QR код';

  @override
  String get loadingWalletTitle => 'Кошелек';

  @override
  String get loadingWalletDescription =>
      'Загрузка кошелька может занять некоторое время, пожалуйста подождите';

  @override
  String get loadingAddressTitle => 'Загрузка адреса';

  @override
  String get loadingAddressDescription =>
      'Загрузка адреса может занять некоторое время, пожалуйста подождите';

  @override
  String get walletSettingsTitle => 'Настройки кошелька';

  @override
  String get deleteWalletAction => 'Удалить кошелек';

  @override
  String get deleteWalletConfirmationTitle => 'Удалить кошелек';

  @override
  String get deleteWalletConfirmation =>
      'Вы действительно хотите удалить кошелек?';

  @override
  String get yesAction => 'Да';

  @override
  String get noAction => 'Нет';

  @override
  String get nodeFailedTitle => 'Ошибка';

  @override
  String get nodeFailedDescription =>
      'Не удалось подключится к ноде, попробуйте ещё раз';

  @override
  String get nodeFailedAction => 'Переподключится';

  @override
  String get nodeFailedAlertTitle => 'Ошибка';

  @override
  String get nodeFailedAlertDescription =>
      'Не удалось подключится к ноде, попробуйте ещё раз';

  @override
  String get transactionsListEmpty =>
      'Транзакции не найдены или ещё не загружены';

  @override
  String get syncStatusSyncedSemantics => 'Адрес синхронизирован с нодой';

  @override
  String get syncStatusScanningFailedSemantics =>
      'Не удалось синхронизировать адрес';

  @override
  String get syncStatusScanningSemantics => 'Нода сканирует ваш адрес';

  @override
  String get localeSelectionTitle => 'Выберите язык';

  @override
  String get nodeSelectionTitle => 'Доступные ноды';

  @override
  String get darkMode => 'Темная тема';

  @override
  String get discordInfo => 'Оффициальный discord:';

  @override
  String get discordFaucetInfo =>
      '* Вы можете получить veil через кран доступный в оффициальном дискорде';

  @override
  String get legalInfo => 'Правовая информация';

  @override
  String get legalTitle => 'Правовая информация';

  @override
  String get createAddress => 'Новый адрес';

  @override
  String get addressCreated => 'Адрес создан';

  @override
  String get homeNavScanQRUnavailable => 'Сканирование QR кодов недоступно';

  @override
  String get sendHistoryRecent => 'Последние переводы';

  @override
  String get noSentTransactions => 'Нет отправленных переводов';

  @override
  String get historyLoadingSemantics => 'История загружается';

  @override
  String get historyDeleted => 'История удалена';

  @override
  String get historyDeleteConfirmationTitle => 'Удалить историю';

  @override
  String get historyDeleteConfirmation =>
      'Вы действительно хотите очистить историю?';

  @override
  String get deleteAllData => 'Удалить все данные';

  @override
  String get deleteAllDataTitle => 'Удалить все данные';

  @override
  String get deleteAllDataConfirmation =>
      'Вы уверены что хотите удалить все данные (включая все кошельки, настройки и историю)?';

  @override
  String get deleteAllDataNotification => 'Все данные удалены';

  @override
  String get addressBookTitle => 'Адресная книга';

  @override
  String get addressBookSearchLabel => 'Поиск адреса';

  @override
  String get addressBookSearchHint => 'Введите адрес или метку';

  @override
  String get addressBookSavedAddresses => 'Сохраненные адреса';

  @override
  String get addressBookLoadingSemantics => 'Загрузка адресной книги';

  @override
  String get addressBookClearConfirmationTitle => 'Очистить адресную книгу';

  @override
  String get addressBookClearConfirmation =>
      'Вы уверены что хотите очистить адресную книгу?';

  @override
  String get addressBookCleared => 'Адресная книга очищена';

  @override
  String get addressBookRemoveSemantics => 'Удалить адрес из адресной книги';

  @override
  String get addressBookEditSemantics => 'Редактировать адрес';

  @override
  String get addressBookNewAddress => 'Новый адрес';

  @override
  String get addressBookNewAddressLabel => 'Метка';

  @override
  String get addressBookNewAddressLabelHint => 'Метка';

  @override
  String get addressBookNewAddressValue => 'Адрес';

  @override
  String get addressBookNewAddressValueHint => 'Адрес';

  @override
  String get addressBookNewAddressCancelButton => 'Отменить';

  @override
  String get addressBookNewAddressSaveButton => 'Сохранить';

  @override
  String get addressBookNewAddressSavedNotification =>
      'Адрес добавлен в адресную книгу';

  @override
  String get noAddressBookAddresses => 'Адреса не найдены';

  @override
  String get addressBookDeleteAddressConfirmationTitle => 'Удалить адрес';

  @override
  String get addressBookDeleteAddressConfirmation =>
      'Вы уверены что хотите удалить адрес из адресной книги?';

  @override
  String get addressBookAddressDeleted => 'Адрес удалён из адресной книги';

  @override
  String get addressBookEditAddress => 'Редактировать адрес';

  @override
  String get addressBookNoLabel => 'Default';

  @override
  String get resetExplorerIconSemantics => 'Сбросить адрес обозревателя';

  @override
  String get resetExplorerTxesIconSemantics =>
      'Сбросить адрес обозревателя транзакций';

  @override
  String get conversionRateInputField => 'Кастомный курс Veil/USD:';

  @override
  String get conversionRateInputFieldHint =>
      'Курс Veil-а по отношению к USD (прим. 0.006)';

  @override
  String get resetConversionRateSemantics => 'Сбросить кастомный курс';

  @override
  String get conversionApiInputField => 'API адрес конвертера валют:';

  @override
  String get conversionApiInputFieldHint =>
      'Должен начинаться с http:// или https://';

  @override
  String get resetConversionApiSemantics =>
      'Сбросить адрес API конвертации валют';

  @override
  String get useCustomConversionRate => 'Использовать кастомный курс валют';
}
