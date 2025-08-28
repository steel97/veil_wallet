// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get title => 'Veilウォレット';

  @override
  String get welcomeTitle => 'Veilへようこそ！';

  @override
  String get welcomeDescription => 'ウォレットをインポートか、新しいウォレットを作成';

  @override
  String get createWallet => '作成する';

  @override
  String get importWallet => 'インポート';

  @override
  String get settingsButton => '設定';

  @override
  String get saveSeedPhraseTitle => 'シードを保存';

  @override
  String get saveSeedPhraseDescription => 'ニーモニックシードを保存:';

  @override
  String get nextButton => '次へ';

  @override
  String get verifySeedPhraseTitle => 'ニーモニックシードは検証';

  @override
  String get verifySeedPhraseDescription => 'ニーモニックシード検証:';

  @override
  String get createWalletButton => 'ウォレットを作成';

  @override
  String get walletNameInputField => 'ウォレット名:';

  @override
  String get walletNameInputFieldHint => 'ウォレット名';

  @override
  String get importSeedTitle => 'インポートウォレット';

  @override
  String get importSeedDescription => '２４語ニーモニックシードを入力してください:';

  @override
  String get walletAdvancedButton => '上級者向け機能';

  @override
  String get walletAdvancedTitle => '上級者向け機能';

  @override
  String get walletEncryptionPasswordInputField => '暗号化用パスフレーズ (存在する場合）:';

  @override
  String get walletEncryptionPasswordInputFieldHint => 'ウォレット暗号化用パスフレーズ';

  @override
  String get walletEncryptionPasswordRepeatInputField => 'ウォレット暗号化用パスフレーズ:';

  @override
  String get walletEncryptionPasswordRepeatInputFieldHint =>
      'ウォレット暗号化用パスフレーズをもう一度入力';

  @override
  String walletImportTransactionsData(String fileName) {
    return 'インポート $fileName';
  }

  @override
  String get saveButton => '保存';

  @override
  String get settingsTitle => '設定';

  @override
  String get nodeUrlInputField => 'ノードのURL:';

  @override
  String get nodeUrlInputFieldHint =>
      'Veil lightwalletノードのURL (http(s)://で始まる)';

  @override
  String get basicAuthInputField => 'ノードのbasic auth:';

  @override
  String get basicAuthInputFieldHint => 'エクスプローラーのノードが空';

  @override
  String get explorerUrlInputField => 'ブロックエクスプローラーのURL：';

  @override
  String get explorerUrlInputFieldHint => 'ブロックエクスプローラーのURL';

  @override
  String get explorerTxInputField => 'トランザクションエクスプローラーのURL：';

  @override
  String get explorerTxInputFieldHint => 'トランザクションエクスプローラーのURL';

  @override
  String get useMinimumUTXOs => '最小限のUTXOを使用する';

  @override
  String get setupBiometricsButton => 'バイオメトリクスの設定';

  @override
  String get aboutButton => 'Appについて';

  @override
  String get biometricsTitle => 'ウォレットを守る';

  @override
  String get biometricsDescription =>
      'ウォレットを保護するために、このアプリの生体認証を設定することを強くお勧めします';

  @override
  String get skipBiometricsButton => 'スキップ（推奨しない）';

  @override
  String get walletTitle => 'ウォレット';

  @override
  String get notificationsAction => 'お知らせ';

  @override
  String get sendButton => '送金';

  @override
  String get receiveButton => '受取';

  @override
  String get buyButton => '購入';

  @override
  String get transactionsLabel => '取引';

  @override
  String get txTypeReceived => '受信';

  @override
  String get txTypeSent => '送信';

  @override
  String get txTypeUnknown => '不明';

  @override
  String get homeNavHome => 'ホーム';

  @override
  String get homeNavExplorer => 'エクスプローラー';

  @override
  String get homeNavScanQR => 'スキャンQR';

  @override
  String get homeNavSettings => '設定';

  @override
  String get homeNavWebsite => 'ウェブサイト';

  @override
  String get passwordsNotMatch => '入力されたパスフレーズが一致しません。';

  @override
  String get seedWordCantBeEmpty => 'シード語が空であるはずがない';

  @override
  String get seedWordWrong => '誤ったシード語';

  @override
  String get seedWordNotMatch => '入力されたシード語が一致しません。';

  @override
  String get aboutTitle => 'Appについて';

  @override
  String get aboutText => 'Veil ウォレット- モバイルVeil暗号通貨ウォレット。\nソースコードはこちら：';

  @override
  String get aboutText2 => '寄付のアドレス:';

  @override
  String get copiedText => 'クリップボードにコピーしました';

  @override
  String get authenticateTitle => 'ウォレット認証';

  @override
  String get authenticateDescription => 'ウォレットにアクセスするには、認証を行ってください';

  @override
  String get authenticateAction => 'ウォレット認証';

  @override
  String get biometricsReason => 'ウォレットのアンロックをするには認証してください';

  @override
  String get biometricsSetupReason => 'バイオメトリクスを設定するには認証してください';

  @override
  String get biometricsRemoveReason => 'バイオメトリクスを解除するには認証してください';

  @override
  String get settingsSaved => '設定保存されました';

  @override
  String get removeBiometricsButton => 'バイオメトリクスの削除';

  @override
  String get loadingAppSemantics => 'ウォレットをロードしています';

  @override
  String get shareTitle => 'コインを受け取る';

  @override
  String get shareDescriptionText => 'このQRコードでコインを受け取る';

  @override
  String get shareAction => 'QRコードを共有';

  @override
  String get shareSubject => 'veilを受け取るための私のQRコード';

  @override
  String shareText(String address) {
    return '私のVeilアドレス: $address';
  }

  @override
  String get newTransactionTitle => '新規トランザクション';

  @override
  String get recipientAddress => '送金先アドレス:';

  @override
  String get recipientAddressHint => '送金先アドレス';

  @override
  String get sendAmount => '金額:';

  @override
  String sendAmountHint(String amount, String overall) {
    return 'veil$overall枚中$amount枚使用可能';
  }

  @override
  String get subtractFeeFromAmount => '手数料を差し引く';

  @override
  String get availableText => '利用可能:';

  @override
  String get sendCoinsNextAction => '次へ';

  @override
  String get makeTxVerifyInvalidAddress => '不正なアドレスが入力されました。';

  @override
  String get makeTxVerifyAmountCantBeEmpty => '支払い総額は空にできない';

  @override
  String get makeTxVerifyAmountMustNotBeNegative => '支払い総額は0より大きい必要があります。';

  @override
  String get makeTxVerifyAmountInvalid => '不正な支払い総額が入力されました。';

  @override
  String get makeTxVerifyAmountNotEnough => '支払い総額が利用可能額を上回る';

  @override
  String get transactionAlertTitle => '取引';

  @override
  String get transactionAlertErrorGeneric => 'エラーが発生しました！トランザクションを作成できません。';

  @override
  String get alertOkAction => 'OK';

  @override
  String get alertCancelAction => 'キャンセル';

  @override
  String get alertSendAction => '送金';

  @override
  String get transactionSummaryRecipient => '送金先:';

  @override
  String get transactionSummaryAmount => '金額:';

  @override
  String get transactionSummaryFee => '取引手数料:';

  @override
  String get transactionSummaryTotal => '合計:';

  @override
  String get transactionAlertErrorSendGeneric =>
      'トランザクションの送信に失敗しました！もう一度お試しください';

  @override
  String get transactionAlertSent => 'トランザクションが送信された！Tx id：';

  @override
  String get flashlightToolip => 'トグル懐中電灯';

  @override
  String get cameraNoPermissions => 'アプリケーションはカメラにアクセスできない';

  @override
  String get scanQRTitle => 'スキャンQRコード';

  @override
  String get loadingWalletTitle => 'ロードしています';

  @override
  String get loadingWalletDescription => 'ウォレットのロードに時間がかかる場合があります。';

  @override
  String get loadingAddressTitle => 'アドレスをロードしています';

  @override
  String get loadingAddressDescription => 'アドレスのロードに時間がかかる場合があります。';

  @override
  String get walletSettingsTitle => 'ウォレットの設定';

  @override
  String get deleteWalletAction => 'ウォレット削除';

  @override
  String get deleteWalletConfirmationTitle => 'ウォレット削除';

  @override
  String get deleteWalletConfirmation => '本当にウォレットを削除しますか？';

  @override
  String get yesAction => 'はい';

  @override
  String get noAction => 'いいえ';

  @override
  String get nodeFailedTitle => 'エラー';

  @override
  String get nodeFailedDescription => 'ノードへの接続に失敗しました。';

  @override
  String get nodeFailedAction => '再接続';

  @override
  String get nodeFailedAlertTitle => 'エラー';

  @override
  String get nodeFailedAlertDescription => 'ノードへの接続に失敗しました。';

  @override
  String get transactionsListEmpty => 'トランザクションが見つからないか、まだロードされていない';

  @override
  String get syncStatusSyncedSemantics => 'アドレスはノードと同期';

  @override
  String get syncStatusScanningFailedSemantics => 'アドレス同期に失敗';

  @override
  String get syncStatusScanningSemantics => 'ノードがアドレスをスキャン中';

  @override
  String get localeSelectionTitle => '言語';

  @override
  String get nodeSelectionTitle => '利用可能なノード';

  @override
  String get darkMode => 'ダークテーマの使用';

  @override
  String get discordInfo => '公式Discord:';

  @override
  String get discordFaucetInfo => '* コインは公式Discordで入手可能。';

  @override
  String get legalInfo => '法的情報';

  @override
  String get legalTitle => '法的情報';

  @override
  String get createAddress => 'アドレスの新規作成';

  @override
  String get addressCreated => 'アドレスの作成に成功';

  @override
  String get homeNavScanQRUnavailable => 'QRコードは利用できません。';

  @override
  String get sendHistoryRecent => '最近のアドレス';

  @override
  String get noSentTransactions => 'まだトランザクションは送信されていない';

  @override
  String get historyLoadingSemantics => 'ロードしています';

  @override
  String get historyDeleted => '履歴の削除';

  @override
  String get historyDeleteConfirmationTitle => '履歴の削除';

  @override
  String get historyDeleteConfirmation => '本当に取引履歴を削除しますか？';

  @override
  String get deleteAllData => 'すべてのデータ消す';

  @override
  String get deleteAllDataTitle => 'すべてのデータ消す';

  @override
  String get deleteAllDataConfirmation => '本当にすべてのデータ（すべてのウォレット、設定、履歴）を削除しますか？';

  @override
  String get deleteAllDataNotification => '全データ消去';

  @override
  String get addressBookTitle => 'アドレス帳';

  @override
  String get addressBookSearchLabel => 'アドレス検索';

  @override
  String get addressBookSearchHint => '検索したいアドレスまたはラベルを入力';

  @override
  String get addressBookSavedAddresses => '保存されたアドレス';

  @override
  String get addressBookLoadingSemantics => 'アドレス帳はロードしています';

  @override
  String get addressBookClearConfirmationTitle => 'アドレス帳の消去';

  @override
  String get addressBookClearConfirmation => '本当にアドレス帳を消去しますか？';

  @override
  String get addressBookCleared => 'アドレス帳消去';

  @override
  String get addressBookRemoveSemantics => 'アドレス帳からアドレスを削除';

  @override
  String get addressBookEditSemantics => 'アドレス帳からアドレスを編集';

  @override
  String get addressBookNewAddress => 'アドレスの新規作成';

  @override
  String get addressBookNewAddressLabel => 'アドレスラベル';

  @override
  String get addressBookNewAddressLabelHint => 'アドレスラベル';

  @override
  String get addressBookNewAddressValue => 'アドレス';

  @override
  String get addressBookNewAddressValueHint => 'アドレス';

  @override
  String get addressBookNewAddressCancelButton => 'キャンセル';

  @override
  String get addressBookNewAddressSaveButton => '保存';

  @override
  String get addressBookNewAddressSavedNotification => 'アドレス帳にアドレスを追加';

  @override
  String get noAddressBookAddresses => 'アドレスリストが空です';

  @override
  String get addressBookDeleteAddressConfirmationTitle => 'アドレス削除';

  @override
  String get addressBookDeleteAddressConfirmation => '本当にアドレス帳からアドレスを削除しますか？';

  @override
  String get addressBookAddressDeleted => 'アドレス帳からアドレスが削除された';

  @override
  String get addressBookEditAddress => 'アドレスを編集';

  @override
  String get addressBookNoLabel => 'Default';

  @override
  String get resetExplorerIconSemantics => 'エクスプローラーのアドレスをリセット';

  @override
  String get resetExplorerTxesIconSemantics => 'エクスプローラーのTXアドレスをリセット';

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
