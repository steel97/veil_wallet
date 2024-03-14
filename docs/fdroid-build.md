tested with `ubuntu 22.04 LTS`

required sdks:
```
sudo apt install android-sdk
sudo apt install sdk-manager
```

don't forget to accept android sdk licenses:
```
yes | sudo sdkmanager --licenses
```

```
cat << EOF > $ANDROID_HOME/licenses/android-sdk-license

8933bad161af4178b1185d1a37fbf41ea5269c55

d56f5187479451eabf01fb78af6dfcb131a6481e

24333f8a63b6825ea9c5514f83c2829b004d1fee
EOF
```


export android sdk path:
```
export ANDROID_HOME=/usr/lib/android-sdk
```

also specify ndk_paths on config.yml (app uses cargo_kit which by default uses NDK: 23.1.7779620)
example:
```
ndk_paths:
  23.1.7779620: ~/android-ndk/android-ndk-23.1.7779620
```

build wallet:
```
sudo -E fdroid build org.veilproject.wallet
```