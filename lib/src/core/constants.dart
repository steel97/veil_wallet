import 'package:veil_wallet/src/core/locale_entry.dart';
import 'package:veil_wallet/src/core/node_entry.dart';

var knownLanguages = [
  LocaleEntry('English', 'en'),
  LocaleEntry('Español', 'es'),
  LocaleEntry('Esperanto', 'eo'),
  LocaleEntry('Русский', 'ru'),
  LocaleEntry('Lietuviškai', 'lt'),
  LocaleEntry('日本語', 'ja'),
];

var knownNodes = [
  NodeEntry('US 1 (explorer)', 'https://explorer-api.veil-project.com'),
  NodeEntry('EU 2', 'https://node02.veil-project.com'),
];

const sourceCodeUrl = 'https://github.com/steel97/veil_wallet';
const donationsAddress =
    'sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp';
const buyCryptoLink =
    'https://nonkyc.io'; // referral link: https://nonkyc.io?ref=651b52ea55acbaf736300f57
const websiteAddress = 'https://veil-project.com';
const discordLabel = 'discord.veil-project.com';
const discordAddress = 'https://discord.veil-project.com';

const stringNotFoundText = 'STRING_NOT_FOUND';
const defaultWalletName = 'Default';

const defaultNodeAddress = 'https://explorer-api.veil-project.com';
const defaultExplorerAddress = 'https://explorer.veil-project.com';
const defaultTxExplorerAddress = 'https://explorer.veil-project.com/tx/{txid}';
const defaultConversionApiUrl = 'https://veil.tools/api/getprice';

const hiddenBalanceMask = '******';

const prefsLocaleStorage = 'veil.locale';
const prefsDarkMode = 'veil.theme';
const prefsWalletsStorage = 'veil.wallets'; // format: <random_id>,<random_id>
const prefsActiveWallet = 'veil.active_wallet'; // format: <wallet_id>
const prefsWalletNames =
    'veil.wallet_names.'; // example veil.wallet_names.123 = Default
const prefsWalletMnemonics =
    'veil.wallet_mnemonics.'; // example veil.wallet_mnemonics.123 = <mnemonic phrase separated by spaces>
const prefsWalletEncryption =
    'veil.wallet_encryption.'; // example veil.wallet_mnemonics.123 = <encryption passphrase>
const prefsWalletTxEncIV = 'veil.wallet_txenciv.';
const prefsWalletTxEncKey = 'veil.wallet_txenckey.';
const prefsWalletAddressIndex = 'veil.wallet_address_index.';
const prefsBiometricsEnabled = 'veil.biometrics_enabled'; // true/false
const prefsActiveAddress = 'veil.active_address';
const prefsWalletHiddenBalances = 'veil.hidden_balances';

// settings
const prefsSettingsNodeUrl = 'veil.settings.node_url';
const prefsSettingsNodeAuth = 'veil.settings.node_auth';
const prefsSettingsExplorerUrl = 'veil.settings.explorer_url';
const prefsSettingsExplorerTxUrl = 'veil.settings.explorer_tx_url';
const prefsSettingsConversionManually = 'veil.settings.conversion_manually';
const prefsSettingsConversionApiUrl = 'veil.settings.conversion_api_url';
const prefsSettingsConversionRate = 'veil.settings.conversion_rate';
const prefsSettingsUseMinimumUTXOs = 'veil.settings.use_minimum_utxos';

// storage
const prefsAddressHistory = 'veil.storage.address_history.';
const prefsAddressBook = 'veil.storage.address_book.';

// other
const biometricsAuthTimeout = 120000; // milliseconds

// background tasks
const walletWatchDelay = 30; // seconds
const conversionWatchDelay = 600; // seconds