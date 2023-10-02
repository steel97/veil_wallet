const sourceCodeUrl = 'https://github.com/steel97/veil_wallet';
const donationsAddress =
    'sv1qqp3twtj249e226mvg55jm0ec36y99xsh5ytnm6hcgvetthuptj2kugpqwcnw6tpnvwrrvutsltnghkg46ayqpw40g6p3knppy3kwgvhr34mkqqqeedkfp';

const stringNotFoundText = 'STRING_NOT_FOUND';

const defaultNodeAddress = 'https://explorer-api.veil-project.com';
const defaultExplorerAddress = 'https://explorer.veil-project.com';
const defaultTxExplorerAddress = 'https://explorer.veil-project.com/tx/{txid}';

const prefsWalletsStorage = 'veil.wallets'; // format: <random_id>,<random_id>
const prefsActiveWallet = 'veil.active_wallet'; // format: <wallet_id>
const prefsWalletNames =
    'veil.wallet_names.'; // example veil.wallet_names.123 = Default
const prefsWalletMnemonics =
    'veil.wallet_mnemonics.'; // example veil.wallet_mnemonics.123 = <mnemonic phrase separated by spaces>
const prefsWalletEncryption =
    'veil.wallet_encryption.'; // example veil.wallet_mnemonics.123 = <encryption passphrase>
const prefsBiometricsEnabled = 'veil.biometrics_enabled'; // true/false
// settings
const prefsSettingsNodeUrl = 'veil.settings.node_url';
const prefsSettingsNodeAuth = 'veil.settings.node_auth';
const prefsSettingsExplorerUrl = 'veil.settings.explorer_url';
const prefsSettingsExplorerTxUrl = 'veil.settings.explorer_tx_url';
const prefsSettingsUseMinimumUTXOs = 'veil.settings.use_minimum_utxos';
