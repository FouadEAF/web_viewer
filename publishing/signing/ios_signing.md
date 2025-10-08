# iOS signing guide

## Automatic signing (simple)
- Add me to your App Store Connect team (Admin/App Manager).
- In Xcode: Signing & Capabilities → Team: select your team.
- Xcode will manage certificates and provisioning profiles.

## Manual signing (advanced)
- Provide the following securely:
  - Distribution certificate `.p12` and password
  - App Store provisioning profile(s)
- We will select these in Xcode or via `exportOptions.plist` during archive.

## Archive and upload
```bash
flutter build ipa --release --export-options-plist=ios/exportOptions.plist
```

Or use Xcode: Product → Archive → Distribute App → App Store Connect.
