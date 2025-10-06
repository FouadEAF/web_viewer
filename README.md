## Clementine’s Cafe – Mobile Web Viewer

A simple Flutter app that wraps and optimizes the browsing experience for the Clementine’s Cafe website. It loads the live site in a secure in‑app WebView so customers can explore the menu, read information, and place orders more conveniently on mobile.

Source: [Clementine’s Cafe website](https://clementinescafe.fr/)

### Features
- **In‑app WebView**: Fast loading of the live site in a native container
- **Mobile‑first UX**: Keeps users inside the app for a smooth experience
- **Cross‑platform**: Android and iOS builds from a single codebase

### Tech Stack
- **Flutter** (Dart)
- **webview_flutter** plugin

### Requirements
- Flutter SDK installed (stable channel)
- Android Studio/Xcode for platform tooling
- Internet access on the device/emulator

### Getting Started
1) Install dependencies:
```bash
flutter pub get
```
2) Run on Android emulator or iOS simulator:
```bash
flutter run
```

### App Icon
This project uses `flutter_launcher_icons`.
- Current icon path: `assets/logo.webp`
- Update `pubspec.yaml` under `flutter_launcher_icons` if you change the icon file.

Generate launcher icons after updating the image:
```bash
flutter pub run flutter_launcher_icons
```

### Build
- Android debug APK:
```bash
flutter build apk --debug
```
- Android release (configure signing first):
```bash
flutter build apk --release
```
- iOS (requires Xcode setup):
```bash
flutter build ios --release
```

### Configuration Notes
- The app loads the live website content from `webview_flutter`. Ensure the device has internet connectivity.
- Android requires the Internet permission (configured by Flutter templates).

### Brand & Contact
- Name: Clementine’s Cafe
- Phone: 01 39 19 95 81
- Email: contact@clementinescafe.fr
- Address: 17 place de la liberté (Place Chennevières), 78700 Conflans‑Sainte‑Honorine

For the latest menu, categories, and information, visit the website: [clementinescafe.fr](https://clementinescafe.fr/)

Developped by [EAF microservice](https://fouadeaf.github.io/EAF-microservice/)