# Notes which may help with common errors

## Repairing flutter project
\* all steps are optional
```
# cleaning build cache
flutter clean
# repairing packages cache
flutter pub cache repair 
# removing packages lock file
rm pubspec.lock
# downloading dependencies
flutter pub get
```

# veil_light_plugin
## Errors in IDE
If you expirience errors in your IDE on `submodules/veil_light_plugin` folder:
```
cd submodules/veil_light_plugin
dart pub get

cd cargokit/build_tool
dart pub get
```


## Additional packages that may be required:
### Windows:
```
# run as administrator
winget install Microsoft.NuGet
```

### Android:
```
recommended java version: 19+
check java to be compatible with gradle
minSdkVersion must be equal in veil_wallet and veil_light_plugin dependency
dependencies/classpath must be equal in veil_wallet and veil_light_plugin dependency
```