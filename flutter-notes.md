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
recommended java version: 21+
for some reason android sdk may use android studio's java which may not be up to date, built is tested with openjdk 21, easiest fix on windows manually set java version in cmd/pwsh:
set JAVA_HOME="c:\Program Files\Java\jdk-21\"
```


To generate icons for platforms use:
```
dart run flutter_launcher_icons
```