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

it's also recommended to accept license with:
```
cat << EOF > $ANDROID_HOME/licenses/android-sdk-license

8933bad161af4178b1185d1a37fbf41ea5269c55

d56f5187479451eabf01fb78af6dfcb131a6481e

24333f8a63b6825ea9c5514f83c2829b004d1fee
EOF
```

download and extract commandlinetools:
```
cd /usr/lib/android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
sudo unzip commandlinetools-linux-11076708_latest.zip
```

don't forget to export android sdk path:
```
export ANDROID_HOME=/usr/lib/android-sdk
```

also specify ndk_paths on config.yml

example:
```
ndk_paths:
  r26c: ~/android-ndk/android-ndk-r26c
```

```
cd ~
wget https://dl.google.com/android/repository/android-ndk-r26c-linux.zip
unzip android-ndk-r26c-linux.zip -d android-ndk/
```
sometimes fdroid command won't work with other apps metadata, just delete other apps metadata to fix it

build wallet:
```
sudo -E fdroid build org.veilproject.wallet
```