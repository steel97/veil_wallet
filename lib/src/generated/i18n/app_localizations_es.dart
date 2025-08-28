// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Veil billetera';

  @override
  String get welcomeTitle => '¡Bienvenido a Veil!';

  @override
  String get welcomeDescription => 'Importe billetera existente o cree nueva';

  @override
  String get createWallet => 'Crear';

  @override
  String get importWallet => 'Importar';

  @override
  String get settingsButton => 'Ajustes';

  @override
  String get saveSeedPhraseTitle => 'Guardar frase semilla';

  @override
  String get saveSeedPhraseDescription =>
      'Guarde la nueva frase semilla de la billetera:';

  @override
  String get nextButton => 'Siguiente';

  @override
  String get verifySeedPhraseTitle => 'Verificar frase semilla';

  @override
  String get verifySeedPhraseDescription =>
      'Comprobando la frase semilla de 24 palabras:';

  @override
  String get createWalletButton => 'Crear billetera';

  @override
  String get walletNameInputField => 'Nombre de la billetera:';

  @override
  String get walletNameInputFieldHint => 'Nombre de la billetera';

  @override
  String get importSeedTitle => 'Importar frase semilla';

  @override
  String get importSeedDescription =>
      'Escribe una frase semilla de 24 palabras';

  @override
  String get walletAdvancedButton => 'Avanzado';

  @override
  String get walletAdvancedTitle => 'Ajustes avanzados';

  @override
  String get walletEncryptionPasswordInputField =>
      'Contraseña de cifrado (si existe):';

  @override
  String get walletEncryptionPasswordInputFieldHint => 'Contraseña de cifrado';

  @override
  String get walletEncryptionPasswordRepeatInputField =>
      'Repetir contraseña de cifrado:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'Repetir contraseña de cifrado';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'Importar $fileName';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get nodeUrlInputField => 'URL del nodo:';

  @override
  String get nodeUrlInputFieldHint =>
      'URL del nodo Veil lightwallet (comienza con http(s)://)';

  @override
  String get basicAuthInputField => 'Autenticación básica del nodo:';

  @override
  String get basicAuthInputFieldHint => 'Vacío para el nodo del explorador';

  @override
  String get explorerUrlInputField => 'Dirección del explorador:';

  @override
  String get explorerUrlInputFieldHint => 'Dirección del explorador';

  @override
  String get explorerTxInputField => 'URL del explorador de Txs:';

  @override
  String get explorerTxInputFieldHint =>
      'Dirección del explorador de transacciones';

  @override
  String get useMinimumUTXOs => 'Utilice UTXO mínimos';

  @override
  String get setupBiometricsButton => 'Configurar datos biométricos';

  @override
  String get aboutButton => 'Acerca de la aplicación';

  @override
  String get biometricsTitle => 'Asegure su billetera';

  @override
  String get biometricsDescription =>
      'Para proteger su billetera, le recomendamos encarecidamente configurar la autenticación biométrica para esta aplicación.';

  @override
  String get skipBiometricsButton => 'Saltar (no recomendado)';

  @override
  String get walletTitle => 'Billetera';

  @override
  String get notificationsAction => 'Notificaciones';

  @override
  String get sendButton => 'Enviar';

  @override
  String get receiveButton => 'Recibir';

  @override
  String get buyButton => 'Comprar';

  @override
  String get transactionsLabel => 'Transacciones';

  @override
  String get txTypeReceived => 'Recibió';

  @override
  String get txTypeSent => 'Enviado';

  @override
  String get txTypeUnknown => 'Desconocido';

  @override
  String get homeNavHome => 'Inicio';

  @override
  String get homeNavExplorer => 'Explorador';

  @override
  String get homeNavScanQR => 'Escanee QR';

  @override
  String get homeNavSettings => 'Ajustes';

  @override
  String get homeNavWebsite => 'Sitio web';

  @override
  String get passwordsNotMatch => 'Las contraseñas no coinciden';

  @override
  String get seedWordCantBeEmpty => 'La palabra semilla no puede estar vacía';

  @override
  String get seedWordWrong => 'Palabra semilla incorrecta';

  @override
  String get seedWordNotMatch => 'La palabra semilla no coincide';

  @override
  String get aboutTitle => 'Acerca de la aplicación';

  @override
  String get aboutText => 'Veil wallet - billetera móvil de criptomonedas Veil';

  @override
  String get aboutText2 => 'Dirección de donaciones:';

  @override
  String get copiedText => 'Copiado al portapapeles';

  @override
  String get authenticateTitle => 'Autenticación';

  @override
  String get authenticateDescription =>
      'Para acceder a la billetera, autenticarse';

  @override
  String get authenticateAction => 'Autenticar';

  @override
  String get biometricsReason =>
      'Por favor autenticarse para desbloquear la billetera';

  @override
  String get biometricsSetupReason =>
      'Autenticarse para configurar datos biométricos';

  @override
  String get biometricsRemoveReason =>
      'Autenticarse para eliminar datos biométricos';

  @override
  String get settingsSaved => 'Ajustes guardados';

  @override
  String get removeBiometricsButton => 'Eliminar datos biométricos';

  @override
  String get loadingAppSemantics => 'Cargando billetera Veil';

  @override
  String get shareTitle => 'Recibir monedas';

  @override
  String get shareDescriptionText =>
      'Utilice este código QR para recibir monedas';

  @override
  String get shareAction => 'Compartir código QR';

  @override
  String get shareSubject => 'Mi código QR para recibir una moneda Veil';

  @override
  String shareText(String address) {
    return 'Mi dirección de Veil: $address';
  }

  @override
  String get newTransactionTitle => 'Nueva transacción';

  @override
  String get recipientAddress => 'Dirección del destinatario:';

  @override
  String get recipientAddressHint => 'Dirección del destinatario';

  @override
  String get sendAmount => 'Monto a enviar:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'Cantidad disponible $amount de $overall veil';
  }

  @override
  String get subtractFeeFromAmount => 'Restar la comisión del monto totál';

  @override
  String get availableText => 'Disponible:';

  @override
  String get sendCoinsNextAction => 'Siguiente';

  @override
  String get makeTxVerifyInvalidAddress => 'La dirección no es válida';

  @override
  String get makeTxVerifyAmountCantBeEmpty =>
      'La cantidad no puede estar vacía';

  @override
  String get makeTxVerifyAmountMustNotBeNegative =>
      'La cantidad debe ser mayor que cero';

  @override
  String get makeTxVerifyAmountInvalid => 'La cantidad no es válida';

  @override
  String get makeTxVerifyAmountNotEnough =>
      'La cantidad es mayor que la disponible';

  @override
  String get transactionAlertTitle => 'Transacción';

  @override
  String get transactionAlertErrorGeneric =>
      '¡Se ha producido un error! No se pudo crear la transacción';

  @override
  String get alertOkAction => 'OK';

  @override
  String get alertCancelAction => 'Cancelar';

  @override
  String get alertSendAction => 'Enviar';

  @override
  String get transactionSummaryRecipient => 'Recipiente:';

  @override
  String get transactionSummaryAmount => 'Monto:';

  @override
  String get transactionSummaryFee => 'Comisión:';

  @override
  String get transactionSummaryTotal => 'Total:';

  @override
  String get transactionAlertErrorSendGeneric =>
      '¡No se pudo enviar la transacción! Intentar otra vez';

  @override
  String get transactionAlertSent => '¡Transacción enviada! Tx id:';

  @override
  String get flashlightToolip => 'Encender o apagar la linterna';

  @override
  String get cameraNoPermissions => 'La aplicación no tiene acceso a la cámara';

  @override
  String get scanQRTitle => 'Escanear código QR';

  @override
  String get loadingWalletTitle => 'Cargando';

  @override
  String get loadingWalletDescription =>
      'La carga de la billetera puede tardar un poco, tenga paciencia';

  @override
  String get loadingAddressTitle => 'Cargando direccion';

  @override
  String get loadingAddressDescription =>
      'La carga de la dirección puede tardar un poco, tenga paciencia';

  @override
  String get walletSettingsTitle => 'Configuración de billetera';

  @override
  String get deleteWalletAction => 'Eliminar billetera';

  @override
  String get deleteWalletConfirmationTitle => 'Eliminar billetera';

  @override
  String get deleteWalletConfirmation =>
      '¿Estás seguro de que quieres eliminar la billetera?';

  @override
  String get yesAction => 'Sí';

  @override
  String get noAction => 'No';

  @override
  String get nodeFailedTitle => 'Error';

  @override
  String get nodeFailedDescription =>
      'No se pudo conectar al nodo, inténtelo de nuevo';

  @override
  String get nodeFailedAction => 'Reconectar';

  @override
  String get nodeFailedAlertTitle => 'Error';

  @override
  String get nodeFailedAlertDescription =>
      'No se pudo conectar al nodo, inténtelo de nuevo';

  @override
  String get transactionsListEmpty =>
      'Transacciones no encontradas o aún no cargadas';

  @override
  String get syncStatusSyncedSemantics =>
      'La dirección está sincronizada con el nodo';

  @override
  String get syncStatusScanningFailedSemantics =>
      'No se pudo sincronizar la dirección';

  @override
  String get syncStatusScanningSemantics => 'El nodo escanea tu dirección';

  @override
  String get localeSelectionTitle => 'Elige lengua';

  @override
  String get nodeSelectionTitle => 'Nodos disponibles';

  @override
  String get darkMode => 'Tema oscuro';

  @override
  String get discordInfo => 'Discord oficial:';

  @override
  String get discordFaucetInfo =>
      '* Puedes conseguir Veil a través del grifo disponible en el Discord oficial.';

  @override
  String get legalInfo => 'Información legal';

  @override
  String get legalTitle => 'Información legal';

  @override
  String get createAddress => 'Crear dirección';

  @override
  String get addressCreated => 'Dirección se crea';

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
