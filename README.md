# Veil light wallet

A crossplatform veil light wallet written with dart/flutter.

## Getting Started
### Requirements:
- [dart/flutter](https://docs.flutter.dev/get-started/install)
- [rust + cargo](https://www.rust-lang.org/tools/install)
- [CMake](https://cmake.org/download/)

#### Windows:
- visual studio 2022 with c++ support

#### Android:
- [JDK 21](https://jdk.java.net/21/) (release builds are made with openjdk 21 under windows platform)
- [SDK](https://developer.android.com/tools/releases/platform-tools)
- [NDK](https://developer.android.com/ndk)
- or install both sdk and ndk via [Android studio](https://developer.android.com/studio)

#### MacOS:
- TO-DO

#### iOS:
- TO-DO

#### IDE:
Project developed with [VS Code](https://code.visualstudio.com/)


Before building it is important to clone [veil_light_plugin](https://github.com/steel97/veil_light_plugin) repository somewhere near copy of this repository (see recommended path here: [pubspec.yaml](pubspec.yaml))

Also see requirements for [veil_light_plugin](https://github.com/steel97/veil_light_plugin)

You may find solutions for common problems here: [flutter-notes.md](flutter-notes.md)

### Building project:

#### Android:
```
# debug on device
flutter run -d <device_id>

# release build in aab format
flutter build appbundle --release

# release build in apk format
flutter build apk --release
```

#### Windows:
```
# release
flutter build windows --release
```

#### Viewing logs:
```
flutter logs
```

## Design notes
To generate icons for platforms use:
```
dart run flutter_launcher_icons
```
You may also look at generator config [flutter_launcher_icons.yaml](flutter_launcher_icons.yaml)

## Localization
App uses **arb** format for localization. User locale detected automatically on app start.

To add new locale you should create file:
```
./lib/l10n/app_<lang_code>.arb
```
You can use [./lib/l10n/app_en.arb](lib/l10n/app_en.arb) or [./lib/l10n/app_ru.arb](lib/l10n/app_ru.arb) as a template

\* [app_en.arb](lib/l10n/app_en.arb) contain some metadata which is not required for other languages, you may safely remove it (see [app_ru.arb](lib/l10n/app_ru.arb) for example)