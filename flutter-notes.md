rapair
```
flutter pub cache repair 
rm pubspec.lock
flutter pub get
```

all oses:
```
use veil_light_plugin as subdirectory (or with relative/absolute path), do not install directly from git!
```

required things:
windows:
```
# run as administrator
winget install Microsoft.NuGet
```

android:
```
recommended java version: 19+
check java to be compatible with gradle
minSdkVersion must be equal in veil_wallet and veil_light_plugin dependency
dependencies/classpath must be equal in veil_wallet and veil_light_plugin dependency
```


To generate icons for platforms use:
```
dart run flutter_launcher_icons
```