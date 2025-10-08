# Android signing guide

## Play App Signing (recommended)
- Enable Play App Signing when creating the app in Play Console.
- Generate an upload keystore for local builds:

```bash
keytool -genkeypair -v \
  -keystore android/upload-keystore.jks \
  -alias upload \
  -keyalg RSA -keysize 2048 -validity 10000
```

Create `android/key.properties`:

```properties
storeFile=upload-keystore.jks
storePassword=REPLACE
keyAlias=upload
keyPassword=REPLACE
```

Then build:

```bash
flutter build appbundle --release
```

## Manual keystore (if not using Play App Signing)
- Provide `.jks/.keystore`, alias, store password, key password.
- We will configure `build.gradle` to sign release builds.
