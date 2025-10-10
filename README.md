## Clementine's Cafe – Mobile Web Viewer

### App Store Descriptions

#### Short Description (80 characters max)
**Clementine's Cafe - Mobile Web Viewer**

#### Full Description

**Clementine's Cafe - Mobile Web Viewer**

Experience Clementine's Cafe directly on your mobile device with this native app that provides fast, seamless access to the restaurant's website.

**Key Features:**
• **Native Mobile Experience** - Browse the cafe's website in a smooth, app-like interface
• **Fast Loading** - Optimized WebView technology for quick page loads
• **Offline Detection** - Smart connectivity monitoring with retry functionality
• **Mobile-First Design** - Clean, intuitive interface designed for mobile users
• **Cross-Platform** - Available on both Android and iOS devices

**What You'll Find:**
• Complete menu with categories and pricing
• Restaurant information and contact details
• Location and hours of operation
• Latest updates and special offers

**About Clementine's Cafe:**
Located at 17 place de la liberté (Place Chennevières) in Conflans-Sainte-Honorine, Clementine's Cafe offers a welcoming atmosphere with delicious food and beverages.

**Contact Information:**
• Phone: 01 39 19 95 81
• Email: contact@clementinescafe.fr
• Website: clementinescafe.fr

**Technical Features:**
• Built with Flutter for optimal performance
• Automatic connectivity monitoring
• Secure browsing with HTTPS support
• Regular updates to ensure compatibility

Download now to have Clementine's Cafe at your fingertips!

---

*Developed by EAF microservice - Your trusted mobile development partner.*

**Keywords:** restaurant, cafe, menu, food, dining, Conflans-Sainte-Honorine, mobile app, web viewer

---

Source: [Clementine's Cafe website](https://clementinescafe.fr/)

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